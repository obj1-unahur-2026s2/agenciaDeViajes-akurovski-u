
class Coordinador
{
    const listaRoles = #{"Guía", "Asistente Logístico", "Acompañante"}

    const cantViajes = 0
    const estaMotivado = true
    const aniosExp = 0
    var rol = ""

    //SETTERS

    method setRol(nuevoRol)
    {
        if(listaRoles.contains(nuevoRol))
        {
            throw new DomainException(message = "Este rol no está disponible en la lista.")
        }

        rol = nuevoRol
    }



    //GETTERS

    method getListaDeRoles() = listaRoles

    method getRol() = rol

    method estaMotivado() = estaMotivado

    method getViajes() = cantViajes

    method getAniosExp() = aniosExp

    method esAltamenteCalificado() 
    {
        if(cantViajes < 20)
            return false

        if(rol.equals("Guía"))
            return estaMotivado

        if(rol.equals("Asistente Logístico"))
            return aniosExp >= 3

        return rol.equals("Acompañante")
    }
}

class Beneficios
{
    const tipo = ""
    const costo = 1
    const estaVigente = false

    method getTipo() = tipo

    method getCosto() = costo

    method estaVigente() = estaVigente
}

class PackViaje
{
    const diasDuracion = 1 
    const precioBase = 1
    const coordinador = null
    const listaBeneficios = []

    //GETTERS

    method getDiasDuracion() = diasDuracion

    method getPrecioBase() = precioBase

    method getCoordinador() = coordinador

    method getListaBeneficios() = listaBeneficios

    method getValorFinal(){}

    method esPackPremium(){}

}

class PackViajeNacional inherits PackViaje
{
    const listaActividades = []
    const provDest = ""

    //GETTERS

    method getListaActividades() = listaActividades

    method getProvDest() = provDest

    override method getValorFinal()
    {
        return 
        self.getPrecioBase() 
        +
        self.getListaBeneficios().sum({x => x.getCosto()})
    }

    override method esPackPremium() 
    {
        return  
                self.getCoordinador().esAltamenteCalificado()
                and
                self.getDiasDuracion() > 10
    }
}

class PackViajeInternacional inherits PackViaje
{
    const listaActividades = []
    const paisDest = ""
    const esLugarDeInteres = true
    const cantEscalas = 0

    //GETTERS

    method getListaActividades() = listaActividades

    method getPaisDest() = paisDest

    method getCantEscalas() = cantEscalas

    method esLugarDeInteres() = esLugarDeInteres

    override method getValorFinal()
    {
        const valorBase =
        self.getPrecioBase() 
        +
        self.getListaBeneficios().sum({x => x.getCosto()})

        return valorBase * 1.2
    }

    override method esPackPremium() 
    {
        return  
                self.esLugarDeInteres()
                and
                self.getCantEscalas() == 0
                and
                self.getDiasDuracion() > 20
    }
}

class PackViajeProvincial inherits PackViajeNacional
{
    const cantCiudades = 1

    method getCantCiudades() = cantCiudades

    override method esPackPremium()
    {
        return
                self.getListaActividades().count() >= 4
                and
                cantCiudades > 5
                and
                self.getListaBeneficios().count({x => x.estaVigente()})
    }

    override method getValorFinal() = super() * 1.05
}
