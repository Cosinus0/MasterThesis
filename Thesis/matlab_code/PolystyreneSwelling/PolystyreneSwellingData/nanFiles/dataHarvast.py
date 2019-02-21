import csv
import numpy 

runninglist = []

# Initialise array

for i in range(1,471+1):

	model = []

	# Open file

	my_file = open("psswellingrun2_%d.nan" %i,"r")
	data = csv.reader(my_file, delimiter=',')

	# saves csv data into reflectance array

	for row,value in data:
		if line[0].isdigit():
		model.append(float(row[1]))

	# Close file

	my_file.close()

	runninglist.append(model)

a = numpy.array(runninglist)
numpy.savetxt("PSmodel", a, delimiter =",")
