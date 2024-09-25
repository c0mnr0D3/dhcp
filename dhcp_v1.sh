fich="dhpd.prueba"

function main () {
clear
echo -e "\t\tDHCP-SCRIPT_V1\n=============================================\n"

read -p "¿Servidor autoritativo? y/n: " auth

	if [ $auth == "y" ]
	then
		echo -e "\n authoritative;\n" >> $fich
	fi

read -p "Dirección de red, Ej: 0.0.0.0: " dir_red
read -p "Mascara de red: " netmask


	echo -e "subnet $dir_red netmask $netmask {" >> $fich
	
			while true
			do
					read -p "¿Quieres indicar un rango? y/n: " bool1
					if [ $bool1 == "y" ]
					then
						read -p "Rango, Ej: 1.2.3.1 1.2.3.2: " range
						echo "range $range;" >> $fich									
					else
						break
					fi
			done
			
			read -p "option domain-name-servers, ej: ns1.internal.example.org google.com: " domain_name_servers
				echo -e "option domain-name-servers $domain_name_servers;" >> $fich
			read -p "option domain-name ej: dominio.org, debe de ir entre comillas: " domain_name
				echo -e "option domain-name $domain_name;" >> $fich
			read -p "Direccion ip del router: " router
				echo -e "option routers	$router;" >> $fich
				read -p "Direccion de broadcast: " broadcast
					echo -e "option broadcast-address $broadcast;"
				read -p "Default lease time, ej: 600, se expresa en segundos: " deftime
					echo -e "default-lease-time $deftime;" >> $fich
				read -p "Max lease time: ej: 7200, se expresa en segundos: " max_time
					echo -e "max-lease-time $max_time;" >> $fich
					echo -e "}\n\n" >> $fich
					
			while true
			do
			read -p "¿Se desea reservar alguna ip para algun equipo? y/n: " bool2
				
				if [ $bool2 == "y" ]
				then
					read -p "Nombre del host: " namehost
					echo -e "host $namehost {" >> $fich
					read -p "Dirección mac: " dirmac
					echo -e "hardware ethernet $dirmac: " >> $fich
					read -p "Direccion ip: " address
					echo -e "fixed-address $address;" >> $fich
					echo -e "}\n\n" >> $fich
				else
					break
				fi 
			done
			
			#systemctl restart networking 2> dhcp_v1.errors
			#netplan apply &> /dev/null
			
}

read -p "¿Quieres cambiar la configuración entera echa del fichero de configuración? y/n: " bool0

	if [ $bool == "y" ]
	then
		echo "" > $fich
		main
	else
		main
	fi
