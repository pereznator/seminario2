import pyodbc
import os
import subprocess
import csv
from dato import Dato
from datetime import datetime

rutaAbsoluta = os.path.abspath(__file__)
dbServer = "localhost"
dbName = "semi2practica1"
dbUsername = "jorge"
dbPassword = "123"

conexion_str = (
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=localhost;"
    "DATABASE=semi2practica1;"
    "UID=jorge;"
    "PWD=123"
)

conexion = pyodbc.connect(conexion_str)

def menu():
  opcion = 0
  while opcion != "6":
    print("************************************************")
    print("* 1. BORRAR MODELO                             *")
    print("* 2. CREAR MODELO                              *")
    print("* 3. EXTRAER MODELO                            *")
    print("* 4. CARGAR INFORMACIÓN                        *")
    print("* 5. REALIZAR CONSULTAS                        *")
    print("* 6. SALIR                                     *")
    print("************************************************")
    opcion = input("Ingresar opcion:\n")

    if opcion == "1":
      borrarModelo()
    elif opcion == "2":
      crearModelo()
    elif opcion == "3":
      extraerModeloTest()
    elif opcion == "4":
      cargarInformacion()
    elif opcion == "5":
      realizarConsultas()
    elif opcion == "6":
      conexion.close()
      print("Adios")
    else:
      print("Opcion Invalida.")


def borrarModelo():
  print("** borrar modelo **")
  rutaEliminarModelo = os.path.join(os.path.dirname(rutaAbsoluta), "scripts\\eliminarModelo.sql")
  comando = [
    'sqlcmd',
    '-S', dbServer,
    '-d', dbName,
    '-U', dbUsername,
    '-P', dbPassword,
    '-i', rutaEliminarModelo
  ]
  resultado = subprocess.run(comando, capture_output=True, text=True)
  print("Salida del comando:", resultado.stdout)
  print("Error del comando:", resultado.stderr)

def crearModelo():
  print("** crear modelo **")
  rutaCrearModelo = os.path.join(os.path.dirname(rutaAbsoluta), "scripts\\crearModelo.sql")
  comando = [
    'sqlcmd',
    '-S', dbServer,
    '-d', dbName,
    '-U', dbUsername,
    '-P', dbPassword,
    '-i', rutaCrearModelo
  ]
  resultado = subprocess.run(comando, capture_output=True, text=True)
  print("Salida del comando:", resultado.stdout)
  print("Error del comando:", resultado.stderr)

def extraerModeloTest():
  print("** extraer modelo **")
  rutaCsv = os.path.join(os.path.dirname(rutaAbsoluta), "practica.csv")
  cursor = conexion.cursor()

  cursor.execute("""
  CREATE TABLE #Temporal (
    passengerId CHAR(6),
    firstName NVARCHAR(100),
    lastName NVARCHAR(100),
    gender NVARCHAR(6),
    age INT,
    nationality NVARCHAR(100),
    airportName NVARCHAR(200),
    airportCountryCode CHAR(2),
    countryName NVARCHAR(200),
    airportContinent NVARCHAR(3),
    continents NVARCHAR(100),
    departureDate NVARCHAR(10),
    arrivalAirport CHAR(3),
    pilotName NVARCHAR(100),
    flightStatus NVARCHAR(15)
  );
  """)

  cursor.execute(f"""
    BULK INSERT #Temporal
    FROM '{rutaCsv}'
    WITH (
      FIELDTERMINATOR = ';',
      ROWTERMINATOR = '\n',
      FIRSTROW = 2
    ); """)
  conexion.commit()
  cursor.close()
  print("Datos insertados.")

def cargarInformacion():
  print("** cargar informacion **")
  cursor = conexion.cursor()
  cursor.execute("""
    INSERT INTO dimPassenger (
      id,
      firstName,
      lastName,
      gender,
      age,
      nationality
    ) 
    SELECT DISTINCT
      passengerId,
      firstName,
      lastName,
      gender,
      age,
      nationality 
    FROM #Temporal;
  """)

  cursor.execute("""
    INSERT INTO dimAirport (
      airportName,
      airportCountryCode,
      countryName,
      airportContinent,
      continents
    )
    SELECT 
      MIN(airportName) AS airportName,
      MIN(airportCountryCode) AS airportCountryCode,
      MIN(countryName) AS countryName,
      MIN(airportContinent) AS airportContinent,
      MIN(continents) AS continents
    FROM #Temporal
    GROUP BY airportName;
  """)

  cursor.execute("""
    INSERT INTO dimFlight (
      idAirport,
      pilotName,
      flightStatus,
      arrivalAirport,
      departureDate
    )
    SELECT 
      dimAirport.id,
      pilotName,
      flightStatus,
      arrivalAirport,
      CASE
        WHEN TRY_CONVERT(DATE, departureDate, 101) IS NOT NULL THEN TRY_CONVERT(DATE, departureDate, 101)
        WHEN TRY_CONVERT(DATE, departureDate, 103) IS NOT NULL THEN TRY_CONVERT(DATE, departureDate, 103)
        ELSE NULL
      END AS departureDate
    FROM #Temporal
    JOIN dimAirport ON #Temporal.airportName = dimAirport.airportName;
  """)

  cursor.execute("""
    INSERT INTO factFlight (
      idPassenger,
      idFlight
    )
    SELECT 
      passengerId,
      dimFlight.id
    FROM #Temporal
    JOIN dimFlight ON #Temporal.arrivalAirport = dimFlight.arrivalAirport AND #Temporal.pilotName = dimFlight.pilotName AND #Temporal.flightStatus = dimFlight.flightStatus;
  """)
  conexion.commit()
  cursor.close()

def realizarConsultas():
  print("** realizar consultas **")
  consultaOpcion = 0
  while consultaOpcion != "11":
    print("************************************************")
    print("* 1. SELECT COUNT (*) de todas las tablas      *")
    print("* 2. porcentaje de pasajeros por genero        *")
    print("* 3. Nacionalidades con su mes de mayor fecha  *")
    print("* 4. COUNT de vuelos por pais                  *")
    print("* 5. Top 5 aeropuertos con mas pasajeros       *")
    print("* 6. COUNT dividido por estado de vuelo        *")
    print("* 7. Top 5 paises mas visitados                *")
    print("* 8. Top 5 continentes mas visitados           *")
    print("* 9. Top 5 edades dividido por genero          *")
    print("* 10. COUNT de vuelos por MM-YYYY              *")
    print("* 11. Regresar                                 *")
    print("************************************************")
    consultaOpcion = input("Ingresar opcion:\n")
    if consultaOpcion == "1":
      consulta(1)
    elif consultaOpcion == "2":
      consulta(2)
    elif consultaOpcion == "3":
      consulta(3)
    elif consultaOpcion == "4":
      consulta(4)
    elif consultaOpcion == "5":
      consulta(5)
    elif consultaOpcion == "6":
      consulta(6)
    elif consultaOpcion == "7":
      consulta(7)
    elif consultaOpcion == "8":
      consulta(8)
    elif consultaOpcion == "9":
      consulta(9)
    elif consultaOpcion == "10":
      consulta(10)
    elif consultaOpcion == "11":
      print("Regresando al menu principal")
    else:
      print("Opcion Invalida.")

def consulta(numConsulta):
  print(f"** consulta {numConsulta} **")

  nombreConsulta = f"consulta{numConsulta}.sql"

  rutaConsulta = os.path.join(os.path.dirname(rutaAbsoluta), f"scripts\\{nombreConsulta}")

  cursor = conexion.cursor()

  comando = [
    'sqlcmd',
    '-S', dbServer,
    '-d', dbName,
    '-U', dbUsername,
    '-P', dbPassword,
    '-i', rutaConsulta
  ]
  resultado = subprocess.run(comando, capture_output=True, text=True)
  print("Salida del comando:", resultado.stdout)
  print("Error del comando:", resultado.stderr)

  if resultado.stdout:
    crearArchivo(resultado.stdout, numConsulta)


def crearArchivo(cadena, numConsulta):
  # Crear la carpeta /output si no existe
    carpeta_output = 'output'
    if not os.path.exists(carpeta_output):
      os.makedirs(carpeta_output)
    
    # Obtener el timestamp del momento actual
    timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
    
    # Crear la ruta del archivo
    nombre_archivo = f"consulta{numConsulta}-{timestamp}.txt"
    ruta_archivo = os.path.join(carpeta_output, nombre_archivo)
    
    # Escribir la cadena en el archivo
    with open(ruta_archivo, 'w', encoding='utf-8') as archivo:
      archivo.write(cadena)
    
    print(f"Archivo guardado en: {ruta_archivo}")


menu()