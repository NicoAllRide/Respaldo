from geopy.geocoders import GoogleV3
import pandas as pd

# Configura tu API key de Google Maps
API_KEY = 'AIzaSyA9d6vMUQx-mWMv4uHDLztlMA-It0ozG2w'  # Reemplaza con tu propia API key

# Ruta al archivo Excel
archivo_excel = 'PARADAS_FALTANTES (1).xlsx'  # Asegúrate de usar la extensión correcta .xlsx

# Cargar la hoja 2 del archivo Excel (índice base 0 → hoja 2 es sheet_name=1)
df = pd.read_excel(archivo_excel, sheet_name=1)

# Asegurar nombre correcto de la columna
df.rename(columns={df.columns[2]: 'Parada oficial'}, inplace=True)

# Convertir la columna a mayúsculas para mejor normalización
df['Parada oficial'] = df['Parada oficial'].astype(str).str.upper()

# Inicializa el geolocalizador
geolocator = GoogleV3(api_key=API_KEY)

# Función para obtener coordenadas
def obtener_coordenadas_chile(direccion):
    if pd.isna(direccion) or not isinstance(direccion, str) or direccion.strip() == "":
        return None, None
    direccion_completa = f"{direccion}, Chile"
    try:
        location = geolocator.geocode(direccion_completa, components={'country': 'CL'})
        if location:
            return location.latitude, location.longitude
        else:
            return None, None
    except Exception as e:
        print(f"Error al geocodificar la dirección {direccion_completa}: {e}")
        return None, None

# Aplicar función
df['Coordenadas'] = df['Parada oficial'].apply(obtener_coordenadas_chile)

# Separar coordenadas en columnas
df[['Latitud', 'Longitud']] = pd.DataFrame(df['Coordenadas'].tolist(), index=df.index)
df.drop(columns=['Coordenadas'], inplace=True)

# Guardar resultado
archivo_salida = 'Coordenadas_Paradas_Oficiales_Hoja2.xlsx'
df.to_excel(archivo_salida, index=False)

print(f"Proceso finalizado. Coordenadas guardadas en: {archivo_salida}")
