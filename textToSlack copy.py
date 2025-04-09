import subprocess

# Ruta correcta de ncat.exe dentro de Nmap
ncat_path = r'C:\Program Files (x86)\Nmap\ncat.exe'  # No uses comillas aquí

# Mensaje exacto a enviar
mensaje = 'STT;nico;3FFFFF;36;2.0.32;1;20250211;16:53:24;006A1303;334;20;3709;51;-39.40000;-73.513433;0.00;0.00;21;1;00000000;00000000;4;1;2290'

# Construcción del comando correcto
comando = f'cmd.exe /c echo {mensaje} | "{ncat_path}" trackingstage.allrideapp.com 50'

# Ejecutar el comando en Windows
try:
    subprocess.run(comando, shell=True, check=True)
    print("✅ Mensaje enviado con éxito:", mensaje)
except subprocess.CalledProcessError as e:
    print("❌ Error al enviar mensaje:", e)
