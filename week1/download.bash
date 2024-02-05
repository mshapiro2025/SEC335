#! /bin/bash
# Passive Recon Class Activity Script
input="/home/champuser/metagoofil_results/burlingtonbeer.txt"
counter=0
while read -r line
do 
	curl --user-agent "Mozilla/5.0" -L "${line}" -o "/home/champuser/metagoofil_results/${counter}.pdf"
	let counter++
done < "${input}"
