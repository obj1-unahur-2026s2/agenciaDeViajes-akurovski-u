
class Coordinador
{
    var listaRoles = #{"Guía", "Asistente Logístico", "Acompañante"}

    var cantViajes = 0
    var estaMotivado = true
    var aniosExp = 0
    var rol = ""

    //SETTERS

    method setRol(nuevoRol)
    {
        if(listaRoles.contains(nuevoRol))
        {
            throw new Exception("Este rol no está disponible")
        }

        rol = nuevoRol
    }



    //GETTERS

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

    method listaBeneficios() = listaBeneficios

}

class PackViajeNacional inherits PackViaje
{
    const listaActividades = []
    const provDest = ""

    //GETTERS

    method getListaActividades() = listaActividades
}

class PackViajeInternacional inherits PackViaje
{
    const listaActividades = []
    const provDest = ""

    //GETTERS

    method getListaActividades() = listaActividades
}
