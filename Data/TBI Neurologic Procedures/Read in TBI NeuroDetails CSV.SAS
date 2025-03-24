/*** The following SAS program will read in the CSV file for the TBI neurosurgery details PUD dataset and 
	 create a temporary SAS dataset with all labels and formats applied. The only code that needs to be 
	 modified is in Steps 1-3 to specify the location where the CSV file is saved and the desired SAS 
	 dataset name.	 
****/

/***	Step 1: : Specify the location where the TBI public use dataset CSV file is stored.	***/
filename CSVFile "C:\Folder\TBI PUD Neuro.csv";

/***	Step 2: Specify the name of SAS dataset to be created. 	***/
%let datasetname=TBINeuroPUD;

/***	Change nothing below this point. Remainder of code is to create the SAS dataset and SAS format catalog.	***/
proc format;
	value	YesNo	0='No'
					1='Yes'
					.='Missing';
run;

options fmtsearch=(work);

data &datasetname;
	%let _EFIERR_ = 0; /* set the ERROR detection macro variable */

	retain patnum surgleak surgfx surghema surgicp surglobe surgtissue surgventri surgoth surgOthDescr;

	length surgothdescr $400.;
	/* Reading in CSV File */
	infile CSVFILE delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;

	input patnum surgleak surgfx surghema surgicp surglobe surgtissue surgventri surgoth surgOthDescr $;

	if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */

	/* Assigning Formats */
	format surgleak surgfx surghema surgicp surglobe surgtissue surgventri surgoth YesNo.;

	/* Assigning Labels */
	label	PatNum='Patient Number'
			SurgLeak='Dura repair for CSF leak'
			SurgFx='Fracture elevation'
			SurgHema='Hematoma drained'
			SurgICP='Intracranial pressure (ICP) monitor'
			SurgLobe='Lobectomy'
			SurgTissue='Tissue Debridement'
			SurgVentri='Ventriculostomy'
			SurgOth='Other neurosurgical procedure'
			SurgOthDescr='Other neurosurgical procedure description'
	;
run;
