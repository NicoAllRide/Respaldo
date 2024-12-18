from geopy.geocoders import GoogleV3
import pandas as pd

# Google Maps API Key
API_KEY = 'AIzaSyA9d6vMUQx-mWMv4uHDLztlMA-It0ozG2w'
# Ruta al archivo Excel
archivo_excel = 'Personal MLP_allride Mina Planta.xlsx'

# Cargar archivo excel
df = pd.read_excel(archivo_excel, header=0, skiprows=0)

# Inicializa el geocodificador de Google
geolocator = GoogleV3(api_key=API_KEY)

# Función obtener coordenadas
def obtener_coordenadas(direccion, comuna):
    try:
        # Dirección, comuna, y país
        direccion_completa = f"{direccion}, {comuna}, Chile"
        location = geolocator.geocode(direccion_completa)
        if location:
            return location.latitude, location.longitude
        else:
            return None, None
    except Exception as e:
        print(f"Error al geocodificar la dirección {direccion_completa}: {e}")
        return None, None

# Aplicar función a las filas
df['Coordenadas'] = df.apply(lambda row: obtener_coordenadas(row['DIRECCION'], row['COMUNA']), axis=1)

# Divide las coordenadas en columnas separadas (latitud y longitud)
df[['Latitud', 'Longitud']] = pd.DataFrame(df['Coordenadas'].tolist(), index=df.index)

# Guarda el DataFrame actualizado en un nuevo archivo Excel
df.to_excel('Personal MLP_allride Mina Planta Coordenadas.xlsx', index=False)
