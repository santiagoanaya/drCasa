class Persona{
	var enfermedades = []
	var cantidadDeCelulas
	var temperatura
	constructor(celulas, temp){
		cantidadDeCelulas = celulas
		temperatura = temp
	}
	method contraerEnfermedad(unaEnfermedad){
		enfermedades.add(unaEnfermedad)
	}
	method enfermedades(){
		return enfermedades
	}
	method cantidadDeCelulas(){
		return cantidadDeCelulas
	}
	method cantidadDeCelulas(celulas){
		cantidadDeCelulas = celulas
	}
	method asignarCelulas(cels){
		cantidadDeCelulas = cels
	}
	method pasarUnDia(){
		enfermedades.forEach({enfermedad => enfermedad.pasarUnDia()})
	}
	method serAfectado(unaPersona){
		enfermedades.forEach({enfermedad => enfermedad.afectarPersona(unaPersona)})
	}
	method asignarTemperatura(temp){
		temperatura = temp
	}
	method aumentarTemperatura(cantidad){
		temperatura += cantidad
	}
	method temperatura(){
		return temperatura
	}
	/*method cantidadDeCelulasAmenazadas(){
		return self.enfermedades().sum({enfermedad => enfermedad.cantidadCelulasAmenazadas()})
	}*/
	method enfermedadesAgresivasYCantidadDeCelulasAmenazadas(){
		return self.enfermedades().filter({enfermedad => enfermedad.agresiva(self)}).sum({enfermedad => enfermedad.cantidadCelulasAmenazadas()})
	} //no andaaaaaaa
	method enfermedadQueMasAfecta(){
		return self.enfermedades().max({enfermedad => enfermedad.cantidadCelulasAmenazadas()})
	}
	method estaEnfermo(){
		return enfermedades != null
	}
	method estaEnComa(){
		return temperatura == 45 or cantidadDeCelulas < 1000000
	}
	method curarEnfermedades(){
		self.setearEnfermedades(self.enfermedades().filter({enfermedad => enfermedad.noTieneCelulasAmenazadas()}))
	}
	method setearEnfermedades(nuevasEnfermedades){
		enfermedades = nuevasEnfermedades
	}
}

class EnfermedadInfecciosa inherits Enfermedad{
	method reproducite(){
		cantidadCelulasAmenazadas = cantidadCelulasAmenazadas * 2
	}
	method agresiva(unaPersona) {
		return cantidadCelulasAmenazadas >= 0.1 * unaPersona.cantidadDeCelulas()
	}
	method afectarPersona(unaPersona){
		if (unaPersona.temperatura() <= 45.0)
		unaPersona.aumentarTemperatura(cantidadCelulasAmenazadas/1000)
		else unaPersona.asignarTemperatura(45)	
	}
}
class EnfermedadAutoinmune inherits Enfermedad{
	method afectarPersona(unaPersona) {
		unaPersona.cantidadDeCelulas(unaPersona.cantidadDeCelulas() - cantidadCelulasAmenazadas)
	//estaria copado un repeat dias * accion	
	}
	method agresiva(unaPersona) {
		 return dias >= 30
		}//afecto a la persona por mas de un mes, osea mas de 30 veces	
}
class Enfermedad{
	var cantidadCelulasAmenazadas
	var dias = 0
	constructor(celulasAmenazadas){
		cantidadCelulasAmenazadas = celulasAmenazadas
	} 
	method cantidadCelulasAmenazadas() {
		return cantidadCelulasAmenazadas
	}
	method dias(){
		return dias
	}
	method pasarUnDia(){
		dias += 1
	}
	method atenuarse(cantidad){
		cantidadCelulasAmenazadas -=cantidad
	}
	method noTieneCelulasAmenazadas(){
		return cantidadCelulasAmenazadas <= 0
	}
}
// temporada 2

class Medico inherits Persona{
	var medicamento
	constructor (celulas, temp, cantidadMedicamento) = super (celulas, temp) {
		medicamento = cantidadMedicamento
		}
	method medicamento(){
		return medicamento
	}
	method medicamento(cantidad){
		medicamento = cantidad
	}
	method atender(persona){
		if(persona.estaEnfermo())
			self.darMedicamento(persona)
	}
	method darMedicamento(persona){
		persona.enfermedades().forEach({enfermedad => enfermedad.atenuarse(medicamento*15)})
		persona.curarEnfermedades()
	}
}
class JefeDeDepartamento inherits Persona{
	var subordinados = []
	constructor (celulas, temp, listaSubordinados) = super (celulas, temp) {
		subordinados = listaSubordinados
		}
	method subordinados(){
		return subordinados
	}	
	method atender(persona){
		self.subordinados().first().atender(persona)
	}
}
object laMuerte{
	method afectarPersona(persona){
		persona.asignarTemperatura(0)
	}
	method agresiva(persona){
		return true
	}
	// falta: no se atenua con ningun medicamento, no falta ninguna celula
}