import csv
import numpy 

runninglist = []

# Initialise array

for i in range(1,963+1):

	reflectance = []

	# Open file

	my_file = open("PIslowslow_%d.dat" %i,"r")
	data = csv.reader(my_file, delimiter=';')

	# saves csv data into reflectance array

	for row in data:
		if "#" in row[0]:
			continue
		reflectance.append(float(row[1]))

	# Close file

	my_file.close()

	runninglist.append(reflectance)

a = numpy.array(runninglist)
numpy.savetxt("PIreflectance", a, delimiter =",")
