from geopy.geocoders import GoogleV3
import pandas as pd

# Configura tu API key de Google Maps
API_KEY = 'AIzaSyA9d6vMUQx-mWMv4uHDLztlMA-It0ozG2w'  # Reemplaza con tu propia API key

# Ruta al archivo Excel
archivo_excel = 'PARADAS FINAL TRP 2025.xlsx'

# Cargar el archivo Excel en un DataFrame
# Asegurando que "DIRECCION FINAL" y "COMUNA" se lean correctamente
df = pd.read_excel(archivo_excel, header=0, skiprows=0, usecols="A,B")

# Renombrar columnas por si hay espacios extra o problemas de formato
df.rename(columns={df.columns[0]: 'DIRECCION FINAL', df.columns[1]: 'COMUNA'}, inplace=True)

# Convertir a mayúsculas para garantizar consistencia
df['DIRECCION FINAL'] = df['DIRECCION FINAL'].astype(str).str.upper()
df['COMUNA'] = df['COMUNA'].astype(str).str.upper()

# Inicializa el geocodificador de Google
geolocator = GoogleV3(api_key=API_KEY)

# Función para obtener coordenadas en base a dirección y comuna
def obtener_coordenadas_chile(direccion, comuna):
    if pd.isna(direccion) or pd.isna(comuna) or not isinstance(direccion, str) or not isinstance(comuna, str) or direccion.strip() == "" or comuna.strip() == "":
        return None, None  # Evita procesar valores vacíos
    
    direccion_completa = f"{direccion}, {comuna}, Chile"
    
    try:
        location = geolocator.geocode(direccion_completa, components={'country': 'CL'})
        if location:
            return location.latitude, location.longitude
        else:
            return None, None
    except Exception as e:
        print(f"Error al geocodificar la dirección {direccion_completa}: {e}")
        return None, None

# Aplica la función a cada fila del DataFrame
df['Coordenadas'] = df.apply(lambda row: obtener_coordenadas_chile(row['DIRECCION FINAL'], row['COMUNA']), axis=1)

# Divide las coordenadas en columnas separadas (Latitud y Longitud)
df[['Latitud', 'Longitud']] = pd.DataFrame(df['Coordenadas'].tolist(), index=df.index)

# Elimina la columna temporal de coordenadas combinadas
df.drop(columns=['Coordenadas'], inplace=True)

# Guarda el DataFrame actualizado en un nuevo archivo Excel
archivo_salida = 'Coordenadas_PARADAS_TRP2025.xlsx'
df.to_excel(archivo_salida, index=False)

print(f"Proceso finalizado. Se guardaron las coordenadas en '{archivo_salida}'.")
