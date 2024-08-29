import json

# JSON como cadena de texto
json_data = '''
[
	{
		"_id": "621baa7068878f576568a904",
		"loc": [-70.51867, -33.486270000000005],
		"lat": -33.486270000000005,
		"lon": -70.51867,
		"sequence": 0
	},
	{
		"_id": "621baa7068878f576568a905",
		"loc": [-70.51867, -33.48631],
		"lat": -33.48631,
		"lon": -70.51867,
		"sequence": 1
	},
	{
		"_id": "621baa7068878f576568a906",
		"loc": [-70.51873, -33.48633],
		"lat": -33.48633,
		"lon": -70.51873,
		"sequence": 2
	},
]

'''

# Ruta del archivo de texto donde se almacenarán las latitudes y longitudes
ruta_txt = 'Nombre ruta.txt'

# Función para extraer latitudes y longitudes y escribir en el archivo de texto
def extraer_lat_lon(json_data, ruta_txt):
    data = json.loads(json_data)
        
    with open(ruta_txt, 'w') as f:
        for item in data:  
            lat = item['lat']
            lon = item['lon']
            f.write(f'  Set Location    {lat}     {lon}\n')
            f.write(f'  Sleep    3s\n')

# Llamar a la función para extraer y escribir los datos
extraer_lat_lon(json_data, ruta_txt)
