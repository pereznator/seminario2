from datetime import datetime

class Dato:
  def __init__(self, passengerId, firstName, lastName, gender, age, nationality, airportName, airportCountryCode, countryName, airportContinent, continents, departureDate, arrivalAirport, pilotName, flightStatus):
    self.passengerId = passengerId
    self.firstName = firstName.replace('"', '').replace("'", '')
    self.lastName = lastName.replace('"', '').replace("'", '')
    self.gender = gender
    self.age = age
    self.nationality = nationality
    self.airportName = airportName.replace('"', '').replace("'", '')
    self.airportCountryCode = airportCountryCode
    self.countryName = countryName.replace('"', '').replace("'", '')
    self.airportContinent = airportContinent
    self.continents = continents
    self.departureDate = self.normalizarFecha(departureDate)
    self.arrivalAirport = arrivalAirport
    self.pilotName = pilotName.replace('"', '').replace("'", '')
    self.flightStatus = flightStatus

  def normalizarFecha(self, rawFecha):
    # Definir formatos posibles de entrada
    formatos = ['%m/%d/%Y', '%d-%m-%Y', '%Y-%m-%d']  # Agrega otros formatos según sea necesario

    # Intentar convertir la fecha con cada formato
    for formato in formatos:
      try:
        fecha = datetime.strptime(rawFecha, formato)
        return fecha.strftime('%Y-%m-%d')  # Formato de salida estándar para SQL Server
      except ValueError:
        continue
    raise ValueError(f"Formato de fecha no reconocido: {rawFecha}")

  def toSql(self):
    return f"('{self.passengerId}', '{self.firstName}', '{self.lastName}', '{self.gender}', {self.age}, '{self.nationality}', '{self.airportName}', '{self.airportCountryCode}', '{self.countryName}', '{self.airportContinent}', '{self.continents}', '{self.departureDate}', '{self.arrivalAirport}', '{self.pilotName}', '{self.flightStatus}')"