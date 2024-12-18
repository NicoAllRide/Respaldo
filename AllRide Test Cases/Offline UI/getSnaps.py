import json

# Ruta de entrada y salida
ruta_json = "snaps.json"  # Cambia esto por la ruta del archivo JSON original
ruta_txt = "ubicaciones_formateadas.txt"  # Archivo de salida con las ubicaciones formateadas

def procesar_json_a_txt(ruta_json, ruta_txt):
    try:
        # Leer el archivo JSON original
        with open(ruta_json, "r") as archivo:
            contenido = archivo.read()
        
        # Reemplazar valores no estándar en JSON
        contenido = contenido.replace("ObjectId(", "").replace("ISODate(", "").replace("NumberInt(", "")
        contenido = contenido.replace(")", "")  # Elimina los paréntesis restantes

        # Convertir a formato JSON estándar
        data = json.loads(contenido)
        
        # Escribir las ubicaciones en el archivo de salida
        with open(ruta_txt, "w") as archivo_salida:
            for idx, item in enumerate(data, start=1):
                lat = item["lat"]
                lon = item["lon"]
                archivo_salida.write(f"Paso {idx}\n")
                archivo_salida.write(f"  Set Location    {lat}     {lon}\n")
                archivo_salida.write(f"  Sleep    3s\n")
        print(f"Archivo generado con éxito: {ruta_txt}")
    except Exception as e:
        print(f"Error procesando el archivo: {e}")

# Llamar a la función
procesar_json_a_txt(ruta_json, ruta_txt)
