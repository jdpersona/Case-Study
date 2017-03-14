###Makefile - Case Study1
###Lauren Darr, Emmanuel Farrugia, Johnson Ekedum, John Heinen

#Rule to run all necessary steps to produce Markdown file of analysis output
all: report.html

#Cleans project of files produced throughout process of cleaning and analyzing data
clean: 	
	rm -f GDP.csv Edu.csv GDP_Clean.csv Edu_Clean.csv Rplots.pdf report.html

#Installs packages needed to complete data cleaning and analyzing of data
load_libraries: Load_Libraries.R
	Rscript $<

#Downloads GDP.csv and Edu.csv from URLs to prepare for data cleansing
import_data: Import_data.R
	Rscript $<

#Runs R code to clean data	
clean_data: clean_data.R load_libraries import_data 
	Rscript $<
	
#Runs R code to analyze data and answers to Case Study 1	
Analysis: Analysis.R load_libraries import_data clean_data 
	Rscript $<

#Rule to produce RMarkdown file for reporting	
report.html: report.Rmd Analysis 
	Rscript -e 'rmarkdown::render("$<")'	
