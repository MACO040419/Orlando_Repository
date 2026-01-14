import csv

clientes = []

def validar_dato(texto):
    '''Funcion que retorna True si el dato es texto y False si es digito o alfanumerico'''
    for letra in texto:
        if letra.isdigit():
            return False
    return True

def cancelar_accion():
    '''Funcion que retorna True si se desea cancelar y False si no se desea y cancela una accion'''
    while True:
        cancelar = input('Desea cancelar esta accion?: ')
        if validar_dato(cancelar) == True:
            if cancelar.upper() == 'SI':
                return True
            elif cancelar.upper() == 'NO':
                return False
            else: 
                print('Respuesta no valida solo se permite si o no')
        else:
            print('Respuesta no valida solo se permite si o no')
            continue

def agregar_clientes():
    """Funcion que se encarga de solicitar los datos de un cliente y los agrega a la lista clientes"""
    while True:
        PApellido = input("\nIngresa el Primer Apellido: ")
        if validar_dato(PApellido) == False:
            print('El apellido no puede contener numeros')
            if cancelar_accion() == True:
                break
            continue
        elif not PApellido:
            print('El apellido no se puede omitir')
            if cancelar_accion() == True:
                break
            continue
        while True:
            SApellido = input("Ingresa el Segundo Apellido(Si desea omitir esta accion pulse ENTER): ")
            if validar_dato(SApellido) == False:
                print('El apellido no puede contener numeros')
                if cancelar_accion() == True:
                    break
                continue
            elif not SApellido:
                SApellido = 'N/A'
            while True:
                Nombre = input("Ingresa el Nombre: ")
                if validar_dato(Nombre) == False:
                    print('El nombre no puede contener numeros')
                    if cancelar_accion() == True:
                        break
                    continue
                elif not Nombre:
                    print('El nombre no se puede omitir')
                    if cancelar_accion() == True:
                        break
                    continue
                while True:
                    Telefono = input("Ingresa el número de teléfono: ")
                    if not Telefono.isdigit() or len(Telefono) != 10:
                        print("El teléfono debe ser un número de 10 dígitos.")
                        if cancelar_accion() == True:
                            break
                        continue
                    while True:
                        Red_social = input('Ingresa el nombre de la red social que te interesa agregar: ')
                        if validar_dato(Red_social) == False:
                            print("La red social no puede contener numeros")
                            if cancelar_accion() == True:
                                break
                            continue
                        elif Red_social.strip() == '':
                            Red_social = 'N/A'
                        while True:
                            if Red_social == 'N/A':
                                identificador_redsocial = 'N/A'
                                break
                            identificador_redsocial = input(f'Como te podemos encontrar en {Red_social}?: ')
                            if validar_dato(identificador_redsocial) == False:
                                print('Solo se permiten caracteres de tipo texto')
                                if cancelar_accion() == True:
                                    Red_social = 'N/A'
                                    identificador_redsocial = 'N/A'
                                    break
                                continue
                            elif not identificador_redsocial:
                                print('No puede omitirse esta opcion vuelva a intentar')
                                if cancelar_accion() == True:
                                    Red_social = 'N/A'
                                    identificador_redsocial = 'N/A'
                                    break
                                continue
                            else:
                                break
                        clientes.append((PApellido,SApellido,Nombre,Telefono, Red_social, identificador_redsocial))
                        print('\nCliente registrado con exito!!!')
                        break

                    break
                
                break

            break

        break
    

def consultar_clientes():
    """Esta función consulta y muestra el listado total de clientes registrados."""
    if clientes:
        print(f'\n{'*' * 56} REPORTE {'*' * 57}')
        print(f'{'*' * 122}') 
        print ('Primer Apellido \t Segundo Apellido \t Nombre o Nombres \t Telefono \t Red social \t Nombre de usuario')
        print (f'{'*' * 122}')
        for cliente in clientes:
            print (f'{cliente[0]:^16} \t {cliente[1]:^16} \t {cliente[2]:^16} \t {cliente[3]:^8} \t {cliente[4]:^10} \t {cliente[5]:^17}')
            print (' ')
        print (f'{'*' * 122}')
    else: 
        print('\nNo hay clientes registrados en el sistema.')

def exportar_csv():
    '''Funcion que exporta la lista clientes a csv'''
    if clientes:
        with open('clientes.csv', 'w', encoding='latin1', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(("Primer Apellido", "Segundo Apellido", "Nombre", "Teléfono", "Red Social", "Nombre de usuario"))
            writer.writerows(clientes)
        print(f"\nSe ha exportado el listado a clientes.csv.")
    else:
        print("No hay clientes para exportar.")

def consultar_cliente_por_telefono():
    '''Funcion que pide un numero de telefono para buscar a el cliente con dicho numero e imprime sus datos en pantalla'''
    if clientes:
        while True:
            telefono_consulta = input("Ingrese el número de teléfono del cliente a consultar: ")
            if validar_dato(telefono_consulta) == False:
                if len(telefono_consulta) != 10:
                    print('La longitud del numero debe ser de 10')
                    if cancelar_accion() == True:
                        break
                    continue
                cliente_encontrado = False
                for cliente in clientes:
                    if cliente[3] == telefono_consulta:
                        print("\nCliente encontrado!!!")
                        print("Primer apellido:", cliente[0])
                        print("Segundo apellido:", cliente[1])
                        print("Nombres:", cliente[2])
                        print("Teléfono:", cliente[3])
                        print("Red social:", cliente[4])
                        print("Identificador en la red social:", cliente[5])
                        cliente_encontrado = True
                        break
                if cliente_encontrado == False:
                    print ('No se encontro a el cliente')
                    if cancelar_accion() == True:
                        break
                    continue
            else:
                print('\nEl numero de telefono no puede ser vacio ni tener letras')
                if cancelar_accion() == True:
                    break
                continue
            break
    else:
        print('\nNo se encontraron clientes para consultar')

while True:
    print(f'\n{"*" * 20} MENU {"*" * 20}')
    print(f'{"*" * 46}')
    print('''1.- Agregar nuevo cliente
2.- Consultar listado total de clientes
3.- Consultar cliente por su numero de telefono
4.- Salir''')
    print(f'{"*" * 46}')
    opcion = input('Introducir la opción deseada: ')
    if opcion.isdigit():
        opcion = int(opcion)
        if opcion == 1:
            agregar_clientes()
        elif opcion == 2:
            consultar_clientes()
            while True:
                if clientes:
                    exportar = input('\n¿Desea exportar el listado de clientes a CSV? (SI/NO): ')
                    if validar_dato(exportar) == True:
                        if exportar.upper() == 'SI':
                            exportar_csv()
                        elif exportar.upper() == 'NO':
                            break
                        else:
                            print('Solo se permite introducir SI o NO')
                            if cancelar_accion() == True:
                                break
                            continue
                    else:
                        print('La respuesta no puede ser vacia ni tener valores numericos')
                        if cancelar_accion() == True:
                            break
                        continue
                break
        elif opcion == 3:
            consultar_cliente_por_telefono()
        elif opcion == 4:
            while True:
                salir = input('\n¿Deseas abandonar el programa? (SI/NO): ')
                if validar_dato(salir) == True:
                    if salir.upper() == 'SI':
                        break
                    elif salir.upper() == 'NO':
                        break
                    else:
                        print('Respuesta no aceptada. Favor de responder solamente SI o NO')
                        if cancelar_accion() == True:
                            break
                        continue
                else:
                    print('No se permiten introducir valores numericos ni vacios')
                    if cancelar_accion() == True:
                        break
                    continue
            if salir.upper() == 'SI':
                break
        else:
            print('Respuesta no aceptada. Vuelva a intentarlo')
            continue
    else:
        print('Respuesta no aceptada. La respuesta debe ser un valor numérico entero')
        continue

print('\nFin del programa. ¡Hasta luego!')