/*** The following SAS program will read in the CSV file for the TBI imaging PUD dataset and 
	 create a temporary SAS dataset with all labels and formats applied. The only code that needs to be 
	 modified is in Steps 1-2 to specify the location where the CSV file is saved and the desired SAS 
	 dataset name.	 
****/

/***	Step 1: : Specify the location where the TBI public use dataset CSV file is stored.	***/
filename CSVFile "C:\Folder\TBI PUD Imaging.csv";

/***	Step 2: Specify the name of SAS dataset to be created. 	***/
%let datasetname=TBIImagePUD;

/***	Change nothing below this point. Remainder of code is to create the SAS dataset.	***/

data &datasetname;
	%let _EFIERR_ = 0; /* set the ERROR detection macro variable */

	retain patnum EDCTImpression EDCTNonTraDescr;
	length EDCTImpression $1880. EDCTNonTraDescr $710.;

	/* Reading in CSV File */
	infile CSVFILE delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;

	input patnum EDCTImpression $ EDCTNonTraDescr $;

	if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */


	/* Assigning Labels */
	label	PatNum='Patient Number'
			EDCTImpression='ED CT Impression'
			EDCTNonTraDescr='Description of non-traumatic findings on ED CT'
	;
run;
