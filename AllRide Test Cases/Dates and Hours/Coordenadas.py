from geopy.geocoders import GoogleV3
import pandas as pd

# Google Maps API Key
API_KEY = 'AIzaSyA9d6vMUQx-mWMv4uHDLztlMA-It0ozG2w'
# Ruta al archivo Excel
archivo_excel = 'Listado Trabajadores 2025-01 ORIZON.xlsx'

# Cargar archivo Excel
df = pd.read_excel(archivo_excel, header=0, skiprows=4)

# Inicializa el geocodificador de Google
geolocator = GoogleV3(api_key=API_KEY)

# Función para obtener coordenadas
def obtener_coordenadas(direccion, comuna):
    try:
        # Construir dirección completa solo para Chile
        direccion_completa = f"{direccion}, {comuna}, Chile"
        location = geolocator.geocode(direccion_completa)
        if location:
            return location.latitude, location.longitude
        else:
            return None, None
    except Exception as e:
        print(f"Error al geocodificar la dirección {direccion_completa}: {e}")
        return None, None

# Filtrar filas con direcciones válidas para Chile
df = df[df['Comuna'].notna()]  # Asegura que la columna "Comuna" no esté vacía

# Aplicar función para obtener coordenadas solo para direcciones en Chile
df['Coordenadas'] = df.apply(lambda row: obtener_coordenadas(row['Dirección'], row['Comuna']), axis=1)

# Divide las coordenadas en columnas separadas (latitud y longitud)
df[['Latitud', 'Longitud']] = pd.DataFrame(df['Coordenadas'].tolist(), index=df.index)

# Guarda el DataFrame actualizado en un nuevo archivo Excel
df.to_excel('Listado Trabajadores 2025-01 ORIZON Coordenadas Chile.xlsx', index=False)
