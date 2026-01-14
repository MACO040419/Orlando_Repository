import PIAGPO14_EQUIPO10_FNS
# estado es la llave en la que puedes tener accesso a Venta de Autbous, si está en "InicioAutobus" no podrás entrar

estado = "InicioAutobus"
while True:
    print("---- Bienvenido a Autotransporte Fast Turtle ----")
    print("------------------ MENÚ -------------------------")
    print(" 1.- Iniciar un nuevo Autobús")
    print(" 2.- Venta de Boletos de Autobús")
    print(" 3.- Cerrar Venta de Boleto de Autobús")
    print(" 4.- Estatus de Venta de Autobús")
    print(" 5.- Salir")
    
    ask = int(input("Selecciona la opción que quieres elegir: "))
    match ask:
        case 1:
            NumAutobus = int(input("Ingrese el número de Autobús: "))
            
            placa1 = PIAGPO14_EQUIPO10_FNS.PartesMatricula1()
            placa2 = PIAGPO14_EQUIPO10_FNS.PartesMatricula2()
            placa3 = PIAGPO14_EQUIPO10_FNS.PartesMatricula3()
            placa = PIAGPO14_EQUIPO10_FNS.FuncionMatricula(placa1,placa2,placa3)
            print(f"La matrícula es: {placa}")
            while True:
                TipoAutobus = int(input("¿Qué autobus necesita? (1.- GRAN TURISMO (48 ASIENTOS) )   (2.- EJECUTIVO (38 ASIENTOS) ): "))
            
                if TipoAutobus == 1:
                    BoletosRestantes = 48
                    PrecioNino = int(input("Ingresa el precio para el Boleto Niño: "))
                    PrecioAdulto = int(input("Ingresa el precio para el Boleto Adulto: "))
                    PrecioAdultoMayor = int(input("Ingresa el precio para el Boleto Adulto Mayor: "))
                    PrecioEspecial = int(input("Ingresa el precio para el Boleto Especial: "))
                    
                    BoletosVentaNino, BoletosRestantes = PIAGPO14_EQUIPO10_FNS.BoletosVentaNino(BoletosRestantes)
                    print(f"Quedan {BoletosRestantes} asientos disponibles para vender")
                    BoletosVentaAdulto, BoletosRestantes = PIAGPO14_EQUIPO10_FNS.BoletosVentaAdulto(BoletosRestantes)
                    print(f"Quedan {BoletosRestantes} asientos disponibles para vender")
                    BoletosVentaAdultoMayor, BoletosRestantes = PIAGPO14_EQUIPO10_FNS.BoletosVentaAdultoMayor(BoletosRestantes)
                    print(f"Quedan {BoletosRestantes} asientos disponibles para vender")
                    BoletosVentaEspecial,BoletosRestantes = PIAGPO14_EQUIPO10_FNS.BoletosVentaEspecial(BoletosRestantes)
                    print(f"Quedaron {BoletosRestantes} asientos disponibles para vender")
                    
                    if BoletosVentaAdultoMayor + BoletosVentaEspecial >  48/2:
                        print("La suma de los Boletos Adulto Mayor y Boletos Especial NO DEBEN ser mayor a la mitad de asientos del Autobus")
                        print("La suma de los Boletos Adulto Mayor y Boletos Especial NO DEBEN ser mayor a la mitad de asientos del Autobus")
                        print("Elije de nuevo un cantidad correcta")
                        print("")
                    else:
                        estado = "VentaBoletos"
                        break
                
                elif TipoAutobus == 2:
                    BoletosRestantes = 38
                    PrecioNino = int(input("Ingresa el precio para el Boleto Niño: "))
                    PrecioAdulto = int(input("Ingresa el precio para el Boleto Adulto: "))
                    PrecioAdultoMayor = int(input("Ingresa el precio para el Boleto Adulto Mayor: "))
                    PrecioEspecial = int(input("Ingresa el precio para el Boleto Especial: "))
                    
                    BoletosVentaNino, BoletosRestantes = PIAGPO14_EQUIPO10_FNS.BoletosVentaNino(BoletosRestantes)
                    print(f"Quedan {BoletosRestantes} asientos disponibles para vender")
                    BoletosVentaAdulto, BoletosRestantes = PIAGPO14_EQUIPO10_FNS.BoletosVentaAdulto(BoletosRestantes)
                    print(f"Quedan {BoletosRestantes} asientos disponibles para vender")
                    BoletosVentaAdultoMayor, BoletosRestantes = PIAGPO14_EQUIPO10_FNS.BoletosVentaAdultoMayor(BoletosRestantes)
                    print(f"Quedan {BoletosRestantes} asientos disponibles para vender")
                    BoletosVentaEspecial,BoletosRestantes = PIAGPO14_EQUIPO10_FNS.BoletosVentaEspecial(BoletosRestantes)
                    print(f"Quedaron {BoletosRestantes} asientos disponibles para vender")
                    if BoletosVentaAdultoMayor + BoletosVentaEspecial > 38/2:
                        print("La suma de los Boletos Adulto Mayor y Boletos Especial NO DEBEN ser mayor a la mitad de asientos del Autobus")
                        print("Elije de nuevo un cantidad correcta")
                        print("")
                    else:
                        estado = "VentaBoletos"
                        break
                    
                    
                else:
                    print("Ingresa un valor valido")
                    continue
        case 2:
            SubtotalNino = 0
            SubtotalAdulto = 0
            SubtotalAdultoMayor = 0
            SubtotalEspecial = 0
            Total = 0
            TotalNino = 0
            TotalAdultoMayor = 0
            TotalAdulto = 0
            TotalEspecial = 0
            if estado == "InicioAutobus":
                print("No se ha iniciado un Autobus para Venta de Boletos de Autobus")
                print("")
            elif estado == "VentaBoletos":
                CantidadBoletosNinos = BoletosVentaNino
                CantidadBoletosAdulto = BoletosVentaAdulto
                CantidadBoletosAdultoMayor = BoletosVentaAdultoMayor
                CantidadBoletosEspecial = BoletosVentaEspecial
                BoletosCompraAdulto = 0
                BoletosCompraNino = 0
                BoletosCompraAdultoMayor = 0
                BoletosCompraEspecial = 0
                while True:
                    print("----------------- MENU -----------------")
                    print(" 1.- Boleto Niño")
                    print(" 2.- Boleto Adulto")
                    print(" 3.- Boleto Adulto Mayor")
                    print(" 4.- Boleto Especial")
                    print(" 5.- Salir")
                    print("")
                    if CantidadBoletosNinos <= 0 and CantidadBoletosAdulto <= 0 and CantidadBoletosAdultoMayor <= 0 and CantidadBoletosEspecial <= 0:
                        print("NO HAY BOLETOS PARA VENDER")
                        estado = "VentaBoletosLleno"
                        break
                    else:
                        
                        askcompra = int(input("Ingresa que tipo de boleto quieras comprar: "))
                        match askcompra:
                            case 1:
                                print(f"Hay {CantidadBoletosNinos} Boletos Niño a la Venta")
                                if CantidadBoletosNinos == 0:
                                    print("No quedan Boletos Niño")
                                    continue
                                BoletosCompraNino = int(input("Ingresa cuantos Boletos quiere comprar: "))
                                if BoletosCompraNino > CantidadBoletosNinos or BoletosCompraNino < 0:
                                    print("Ingresa un valor válido")
                                
                                
                                CantidadBoletosNinos = CantidadBoletosNinos - BoletosCompraNino
                                SubtotalNino = BoletosCompraNino * PrecioNino
                                print("El subtotal es: " + str(SubtotalNino))
                                TotalNino = TotalNino + SubtotalNino
                            case 2:
                                print(f"Hay {CantidadBoletosAdulto} Boletos Adulto a la Venta")
                                if CantidadBoletosAdulto == 0:
                                    print("No quedan Boletos Adutlo")
                                    continue
                                BoletosCompraAdulto = int(input("Ingresa cuantos Boletos quiere comprar: "))
                                if BoletosCompraAdulto > CantidadBoletosAdulto or BoletosCompraAdulto < 0:
                                    print("Ingresa un valor válido")
                                
                                
                                CantidadBoletosAdulto = CantidadBoletosAdulto - BoletosCompraAdulto
                                SubtotalAdulto = BoletosCompraAdulto * PrecioAdulto
                                print("El subtotal es: " + str(SubtotalAdulto))
                                TotalAdulto = TotalAdulto + SubtotalAdulto
                            case 3:
                                print(f"Hay {CantidadBoletosAdultoMayor} Boletos Adulto mayor a la Venta")
                                if CantidadBoletosAdultoMayor == 0:
                                    print("No quedan Boletos Adulto Mayor")
                                    continue
                                BoletosCompraAdultoMayor = int(input("Ingresa cuantos Boletos quieres comprar: "))
                                if BoletosCompraAdultoMayor > CantidadBoletosAdultoMayor or BoletosCompraAdultoMayor < 0:
                                    print("Ingresa un valor válido")
                                
                                    
                                CantidadBoletosAdultoMayor = CantidadBoletosAdultoMayor - BoletosCompraAdultoMayor
                                SubtotalAdultoMayor = BoletosCompraAdultoMayor * PrecioAdultoMayor
                                print("El subtotal es " + str(SubtotalAdultoMayor))
                                TotalAdultoMayor = TotalAdultoMayor + SubtotalAdultoMayor
                            case 4:
                                print(f"Hay {CantidadBoletosEspecial} Boletos Especial a la Venta")
                                if BoletosVentaEspecial == 0:
                                    print("No quedan Boletos Especial")
                                    continue
                                BoletosCompraEspecial = int(input("Ingresa cuantos Boletos quiere comprar: "))
                                if BoletosCompraEspecial > CantidadBoletosEspecial or BoletosCompraEspecial <0:
                                    print("Ingresa un valor válido")
                                

                                CantidadBoletosEspecial = CantidadBoletosEspecial - BoletosCompraEspecial
                                SubtotalEspecial = BoletosCompraEspecial * PrecioEspecial
                                print("El subtotal es: " + str(SubtotalEspecial))
                                TotalEspecial = TotalEspecial + SubtotalEspecial
                            case 5:
                                print("")
                                break
                            case _:
                                print("Ingresa un valor correcto")
                                continue
            elif estado == "VentaBoletosLleno":
                print("EXISTENCIAS AGOTADAS")
                print("")
            elif estado == "CierreVentaBoleto":
                print("Ya se han cerrado las operaciones del autobus")
            
        case 3:
            boletosNoVendidos = (BoletosVentaNino + BoletosVentaAdulto + BoletosVentaAdultoMayor + BoletosVentaEspecial) - (BoletosCompraAdulto+BoletosCompraAdultoMayor+BoletosCompraEspecial+BoletosCompraNino)
            if estado == "VentaBoletosLleno" or estado == "VentaBoletos":
                print (f"""
                ********* CIERRE VENTAS DE BOLETO DE AUTOBUS ***********
                Boletos no vendidos: {boletosNoVendidos}
                Boletos vendidos: {BoletosCompraAdulto+BoletosCompraNino+BoletosCompraAdultoMayor+BoletosCompraEspecial}
                Tipo de boleto       Precio             Cantidad                       Subtotal
                Adulto                 {PrecioAdulto}                  {BoletosCompraAdulto}                            {TotalAdulto}
                Niño                   {PrecioNino}                  {BoletosCompraNino}                             {TotalNino}
                Adulto Mayor           {PrecioAdultoMayor}                  {BoletosCompraAdultoMayor}                            {TotalAdultoMayor}
                Especial               {PrecioEspecial}                   {BoletosCompraEspecial}                             {TotalEspecial}
                *******************************
                
                ¡El autobus esta listo para salir!
                """)
                estado = "CierreVentaBoleto"
        case 4:
            if estado == "VentaBoletosLleno" or estado == "VentaBoletos":
                
                print("")
                print("--------------- ESTATUS DE VENTA -----------------")
                print(f"Numero de Autobus {NumAutobus}")
                print(f"Matrícula: {placa}")
                print(f"Numero de boletos vendidos {BoletosCompraAdulto + BoletosCompraNino + BoletosCompraAdultoMayor + BoletosCompraEspecial}")
                print("")
                print("Detalles de Boletos Vendidos: ")
                print("Tipo Boleto      Precio  Cantidad  Subtotal ")
                print(f"Boleto Niño      {PrecioNino}     {BoletosCompraNino}      {TotalNino}")
                print(f"Boleto Adulto    {PrecioAdulto}     {BoletosCompraAdulto}      {TotalAdulto}")
                print(f"Boleto Adulto M. {PrecioAdultoMayor}     {BoletosCompraAdultoMayor}      {TotalAdultoMayor}")
                print(f"Boleto Especial  {PrecioEspecial}      {BoletosCompraEspecial}       {TotalEspecial}")
                print("")
                print("Detalles de Boletos No Vendidos: ")
                print("Tipo Boleto     Cantidad Vendida    Maximo Permitido    Cantidad Disponible")
                print(f"Boleto Niño      {BoletosCompraNino}                      -                {CantidadBoletosNinos}")
                print(f"Boleto Adulto    {BoletosCompraAdulto}                      -                {CantidadBoletosAdulto}")
                print(f"Boleto Adulto M. {BoletosCompraAdultoMayor}                      {BoletosVentaAdultoMayor}                 {CantidadBoletosAdultoMayor}")
                print(f"Boleto Especial  {BoletosCompraEspecial}                      {BoletosVentaEspecial}                 {CantidadBoletosEspecial} ")
                print("--------------------------------------------------")
            elif estado == "CierreVentaBoleto":
                print("Ya se han cerrado las operaciones del autobus")
        case 5:
            print("Finalizando Programa")
            print("¡MUCHAS GRACIAS POR OCUPAR NUESTRO PROGRAMA!")
            print("¡Buen viaje!")
            break
            