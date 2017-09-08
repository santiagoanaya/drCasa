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
	method estaEnComa(){
	return temperatura == 45 or cantidadDeCelulas < 1000000
	}
}

class EnfermedadInfecciosa{
	var cantidadCelulasAmenazadas
	var dias = 0
	constructor (celulasAmenazadas){
		cantidadCelulasAmenazadas = celulasAmenazadas
	}
	method cantidadCelulasAmenazadas() {
		return cantidadCelulasAmenazadas
	}
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
	method pasarUnDia(){
		dias += 1
	}
	method dias(){
		return dias
	}
}
class EnfermedadAutoinmune{
	var cantidadCelulasAmenazadas
	var dias = 0
	constructor (celulasAmenazadas){
		cantidadCelulasAmenazadas = celulasAmenazadas
	}
	method cantidadCelulasAmenazadas() {
		return cantidadCelulasAmenazadas
	}
	method dias(){
		return dias
	}
	method afectarPersona(unaPersona) {
		unaPersona.cantidadDeCelulas(unaPersona.cantidadDeCelulas() - cantidadCelulasAmenazadas)
	//estaria copado un repeat dias * accion	
	}
	method pasarUnDia(){
		dias += 1
	}
	method agresiva(unaPersona) {
		 return dias >= 30
		}//afecto a la persona por mas de un mes, osea mas de 30 veces	
}