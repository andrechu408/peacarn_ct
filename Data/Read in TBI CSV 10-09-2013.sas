/*** The following SAS program will read in the CSV file for the TBI PUD dataset and 
	 create a temporary SAS dataset with all labels and formats applied. The only code 
	 that needs to be modified is in Steps 1-3 to specify the location where the CSV 
	 file is saved and the desired SAS dataset name.	 ****/

/***	Step 1: : Specify the location where the TBI public use dataset CSV file is stored.	***/
filename CSVFile "C:\Folder\TBI PUD 10-09-2013.csv";

/***	Step 2: Specify the name of SAS dataset to be created. 	***/
%let datasetname=TBIPUD;

/***	Change nothing below this point. Remainder of code is to create the SAS dataset and SAS format catalog.	***/
proc format;
	value EmplType	1='Nurse Practitioner'
					2='Physician Assistant'
					3='Resident'
					4='Fellow'
					5='Faculty'
					.='Missing';
	value CertType	1='Emergency Medicine'
					2='Pediatrics'
					3='Pediatrics Emergency Medicine'
					4='Emergency Medicine and Pediatrics'
					90='Other'
					.='Missing';
	value InjMech	1='Occupant in motor vehicle collision (MVC)'
					2='Pedestrian struck by moving vehicle'
					3='Bike rider struck by automobile'
					4='Bike collision or fall from bike while riding'
					5='Other wheeled transport crash'
					6='Fall to ground from standing/walking/running'
					7='Walked or ran into stationary object'
					8='Fall from an elevation'
					9='Fall down stairs'
					10='Sports'
					11='Assault'
					12='Object struck head - accidental'
					90='Other mechanism'
					.='Missing';
	value InjSev	1='Low'
					2='Moderate'
					3='High'
					.='Missing';
	Value YesNoPV	0='No'
					1='Yes'
					91='Pre-verbal/Non-verbal'
					. = 'Missing';
	value YesNoLOC	0='No'
					1='Yes'
					2='Suspected'
					.='Missing';
	value LocLen	1='< 5 sec'
					2='5 sec - < 1 min'
					3='1 - 5 min'
					4='> 5 min'
					92='Not applicable'
					.='Missing';
	value	YesNo	0='No'
					1='Yes'
					.='Missing';
	value YesNoNA	0='No'
					1='Yes'
					92='Not applicable'
					.='Missing';
	value SeizOcc	1='Immediately on contact'
					2='Within 30 minutes of injury'
					3='> 30 minutes after injury'
					92='Not applicable'
					.='Missing';
	value SeizLen	1='< 1 min'
					2='1 - < 5 min'
					3='5 - 15 min'
					4='> 15 min'
					92='Not applicable'
					.='Missing';
	value HASev		1='Mild (barely noticeable)'
					2='Moderate'
					3='Severe (intense)'
					92='Not applicable'
					.='Missing';
	value VomEpi	1='Once'
					2='Twice'
					3='> 2 times'
					92='Not applicable'
					.='Missing';
	value Start		1='Before head injury'
					2='Within 1 hr of event'
					3='1 - 4 hrs after event'
					4='> 4 hrs after event'
					92='Not applicable'
					.='Missing';
	value VomLast	1='< 1 hr before ED evaluation'
					2='1 - 4 hrs before ED evaluation'
					3='> 4 hrs before ED evaluation'
					92='Not applicable'
					.='Missing';
	value GCSEye	1='None'
					2='Pain'
					3='Verbal'
					4='Spontaneous'
					.='Missing';
	value GCSVerbal	1='None'
					2='Incomprehensible sounds (moans)'
					3='Inappropriate words (cries to pain)'
					4='Confused (irritable/cries)'
					5='Oriented (coos/babbles)'
					.='Missing';
	value GCSMotor	1='None'
					2='Abnormal extension posturing'
					3='Abnormal flexure posturing'
					4='Withdraws to pain'
					5='Localizes pain (withdraws to touch)'
					6='Follow commands (spontaneous movement)'
					.='Missing';
	value GCSGroup	1='3 - 13'
					2='14 - 15'
					.='Missing';
	value YesNoUnc	0='No'
					1='Yes'
					2='Unclear exam'
					.='Missing';
	value YesNoClo	0='No/Closed'
					1='Yes'
					.='Missing';
	value HemLoc	1='Frontal'
					2='Occipital'
					3='Parietal/Temporal'
					92='Not applicable'
					.='Missing';
	value HemSz		1='Small (<1 cm, barely palpable)'
					2='Medium (1-3 cm)'
					3='Large (>3 cm)'
					92='Not applicable'
					.='Missing';
	value AgeTwo	1='< 2 years'
					2='>= 2 years';
	value gender	1='Male'
					2='Female'
					.='Missing';
	value Ethn		1='Hispanic'
					2='Non-Hispanic'
					.='Missing';
	value Race		1='White'
					2='Black'
					3='Asian'
					4='American Indian/Alaskan Native'
					5='Pacific Islander'
					90='Other'
					.='Missing';
	value Disp		1='Home'
					2='OR'
					3='Admit - general inpatient'
					4='Admit short-stay (<24 hr)/observation unit'
					5='ICU'
					6='Transferred to another hospital'
					7='AMA'
					8='Death in the ED'
					90='Other'
					.='Missing';
run;

options fmtsearch=(work);

data &datasetname;
	%let _EFIERR_ = 0; /* set the ERROR detection macro variable */

	/* Reading in CSV File */
	infile CSVFILE delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;

	input 	PatNum EmplType Certification InjuryMech High_impact_InjSev Amnesia_verb LOCSeparate LocLen Seiz SeizOccur
			SeizLen ActNorm HA_verb HASeverity HAStart Vomit VomitNbr VomitStart VomitLast Dizzy Intubated
			Paralyzed Sedated GCSEye GCSVerbal GCSMotor GCSTotal GCSGroup AMS AMSAgitated AMSSleep AMSSlow AMSRepeat AMSOth SFxPalp
			SFxPalpDepress FontBulg SFxBas SFxBasHem SFxBasOto SFxBasPer SFxBasRet SFxBasRhi Hema HemaLoc HemaSize Clav
			ClavFace ClavNeck ClavFro ClavOcc ClavPar ClavTem NeuroD NeuroDMotor NeuroDSensory NeuroDCranial NeuroDReflex NeuroDOth
			OSI OSIExtremity OSICut OSICspine OSIFlank OSIAbdomen OSIPelvis OSIOth Drugs CTForm1 IndAge IndAmnesia
			IndAMS IndClinSFx IndHA IndHema IndLOC IndMech IndNeuroD IndRqstMD IndRqstParent IndRqstTrauma IndSeiz IndVomit IndXraySFx
			IndOth CTSed CTSedAgitate CTSedAge CTSedRqst CTSedOth AgeInMonth AgeinYears AgeTwoPlus Gender Ethnicity
			Race Observed EDDisposition CTDone EDCT PosCT Finding1 Finding2 Finding3 Finding4 Finding5 Finding6
			Finding7 Finding8  Finding9 Finding10 Finding11 Finding12  Finding13  Finding14 Finding20 Finding21 Finding22 Finding23
			DeathTBI HospHead HospHeadPosCT Intub24Head Neurosurgery PosIntFinal;

	if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */

	/* Assigning Formats */
		format EmplType EmplType.;
		format Certification CertType.;
		format InjuryMech InjMech.;
		format High_impact_InjSev InjSev.;
		format Amnesia_verb YesNoPV.;
		format LOCSeparate YesNoLOC.;
		format LocLen LocLen.;
		format Seiz YesNo.;
		format SeizOccur SeizOcc.;
		format SeizLen SeizLen.;
		format ActNorm YesNo.;
		format HA_verb YesNoPV.;
		format HASeverity HASev.;
		format HAStart Start.;
		format Vomit YesNo.;
		format VomitNbr VomEpi.;
		format VomitStart Start.;
		format VomitLast VomLast.;
		format Dizzy YesNo.;
		format Intubated YesNo.;
		format Paralyzed YesNo.;
		format Sedated YesNo.;
		format GCSEye GCSEye.;
		format GCSVerbal GCSVerbal.;
		format GCSMotor GCSMotor.;
		format GCSGroup GCSGroup.;
		format AMS YesNo.;
		format AMSAgitated AMSSleep AMSSlow AMSRepeat AMSOth YesNoNA.;
		format SFxPalp YesNoUnc.;
		format SFxPalpDepress YesNoNA.;
		format FontBulg YesNoClo.;
		format SFxBas YesNo.;
		format SFxBasHem SFxBasOto SFxBasPer SFxBasRet SFxBasRhi YesNoNA.;
		format Hema YesNo.;
		format HemaLoc HemLoc.;
		format HemaSize HemSz.;
		format Clav YesNo.;
		format ClavFace ClavNeck ClavFro ClavOcc ClavPar ClavTem YesNoNA.;
		format NeuroD YesNo.;
		format NeuroDMotor NeuroDSensory NeuroDCranial NeuroDReflex NeuroDOth YesNoNA.;
		format OSI YesNo.;
		format OSIExtremity OSICut OSICspine OSIFlank OSIAbdomen OSIPelvis OSIOth YesNoNA.;
		format Drugs YesNo.;
		format CTForm1 YesNo.;
		format IndAge IndAmnesia IndAMS IndClinSFx IndHA IndHema IndLOC IndMech IndNeuroD IndRqstMD IndRqstParent IndRqstTrauma
				IndSeiz IndVomit IndXraySFx IndOth YesNoNA.;
		format CTSed YesNoNA.;
		format CTSedAgitate CTSedAge CTSedRqst CTSedOth YesNoNA.;
		format AgeTwoPlus AgeTwo.;
		format Gender Gender.;
		format Ethnicity Ethn.;
		format Race Race.;
		format Observed YesNo.;
		format EDDisposition Disp.;
		format CTDone YesNo.;
		format EDCT YesNoNA.;
		format PosCT YesNoNA.;
		format Finding1 Finding2 Finding3 Finding4 Finding5 Finding6 Finding7 Finding8 Finding9 Finding10 Finding11 
				Finding12 Finding13 Finding14 Finding20 Finding21 Finding22 Finding23 YesNoNA.;
		format DeathTBI YesNo.;
		format HospHead YesNo.;
		format HospHeadPosCT YesNo.;
		format Intub24Head YesNo.;
		format Neurosurgery YesNo.;
		format PosIntFinal YesNo.;

	/* Assigning Labels */
	label	PatNum='Patient Number'
			EmplType='Position of physician completing data sheet'
			Certification='Certification of physician completing the form'
			InjuryMech='Injury mechanism'
			High_impact_InjSev='Severity of injury mechanism'
			Amnesia_verb='Does the patient have amnesia for the event?'
			LOCSeparate='History of loss of consciousness?'
			LocLen='Duration of loss of consciousness'
			Seiz='Post-traumatic seizure?'
			SeizOccur='When did the post-traumatic seizure occur?'
			SeizLen='Duration of post-traumatic seizure'
			ActNorm='Does the parent think the child is acting normally / like themself?'
			HA_verb='Headache at time of ED evaluation?'
			HASeverity='Severity of headache'
			HAStart='When did the headache start?'
			Vomit='Vomiting (at any time after injury)?'
			VomitNbr='How many vomiting episodes?'
			VomitStart='When did the vomiting start?'
			VomitLast='When was the last episode of vomiting?'
			Dizzy='Dizziness (at ED evaluation)?'
			Intubated="Is the physician's evaluation being made after the patient was intubated?"
			Paralyzed="Is the physician's evaluation being made after the patient was pharmacologically paralyzed?"
			Sedated="Is physician's evaluation being made after the patient was pharmacologically sedated?"
			GCSEye='GCS component: eye'
			GCSVerbal='GCS component: verbal'
			GCSMotor='GCS component: motor'
			GCSTotal='GCS Total'
			GCSGroup='GCS: 14-15'
			AMS='GCS < 15 or other signs of altered mental status (agitated, sleepy, slow to respond, repetitive questions in the ED, other)'
			AMSAgitated='Other signs of altered mental status: agitated'
			AMSSleep='Other signs of altered mental status: sleepy'
			AMSSlow='Other signs of altered mental status: slow to respond'
			AMSRepeat='Other signs of altered mental status: repetitive questions in ED'
			AMSOth='Other signs of altered mental status: other'
			SFxPalp='Palpable skull fracture?'
			SFxPalpDepress='If the patient has a palpable skull fracture, does the fracture feel depressed?'
			FontBulg='Anterior fontanelle bulging?'
			SFxBas='Signs of basilar skull fracture?'
			SFxBasHem='Basilar skull fracture: hemotympanum'
			SFxBasOto='Basilar skull fracture: CSF otorrhea'
			SFxBasPer='Basilar skull fracture: periorbital ecchymosis (raccoon eyes)'
			SFxBasRet="Basilar skull fracture: retroauricular ecchymosis (battle's sign)"
			SFxBasRhi='Basilar skull fracture: CSF rhinorrhea'
			Hema='Raised scalp hematoma(s) or swelling(s)?'
			HemaLoc='Hematoma(s) or swelling(s) location(s) involved'
			HemaSize='Size (diameter) of largest hematoma or swelling'
			Clav='Any evidence of trauma (including laceration, abrasion, hematoma) above the clavicles (includes neck/face/scalp)?'
			ClavFace='Trauma above the clavicles region: face'
			ClavNeck='Trauma above the clavicles region: neck'
			ClavFro='Trauma above the clavicles region: scalp-frontal'
			ClavOcc='Trauma above the clavicles region: scalp-occipital'
			ClavPar='Trauma above the clavicles region: scalp-parietal'
			ClavTem='Trauma above the clavicles region: scalp-temporal'
			NeuroD='Neurological deficit (other than mental status)?'
			NeuroDMotor='Neurological deficit: motor'
			NeuroDSensory='Neurological deficit: sensory'
			NeuroDCranial='Neurological deficit: cranial nerve (includes pupil reactivity)'
			NeuroDReflex='Neurological deficit: reflexes'
			NeuroDOth='Neurological deficit: other deficits (e.g. cerebellar, gait)'
			OSI='Clinical evidence of other (non-head) substantial injuries: (includes but not limited to fractures, intra-abdominal injuries, intra-thoracic injuries and lacerations requiring operating room repair.)'
			OSIExtremity='Other (non-head) substantial injury: extremity'
			OSICut='Other (non-head) substantial injury: laceration requiring repair in the operating room'
			OSICspine='Other (non-head) substantial injury: c-spine'
			OSIFlank='Other (non-head) substantial injury: chest/back/flank'
			OSIAbdomen='Other (non-head) substantial injury:  intra-abdominal'
			OSIPelvis='Other (non-head) substantial injury: pelvis'
			OSIOth='Other (non-head) substantial injury: other'
			Drugs='Clinical suspicion for alcohol or drug intoxication (not by laboratory testing)?'
			CTForm1='Is a head CT, skull x-ray or head MRI being ordered or obtained?'
			IndAge='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: young age'
			IndAmnesia='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: amnesia'
			IndAMS='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: decreased mental status'
			IndClinSFx='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: clinical evidence of skull fracture'
			IndHA='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: headache'
			IndHema='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: scalp hematoma'
			IndLOC='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: loss of consciousness'
			IndMech='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: mechanism'
			IndNeuroD='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: neurological deficit (other than mental status)'
			IndRqstMD='If a CT is being ordered or obtained  check the most important indications in influencing the decision to obtain a head CT: referring MD request'
			IndRqstParent='If a CT is being ordered or obtained  check the most important indications in influencing the decision to obtain a head CT: parental anxiety/request'
			IndRqstTrauma='If a CT is being ordered or obtained  check the most important indications in influencing the decision to obtain a head CT: trauma team request'
			IndSeiz='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: seizure'
			IndVomit='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: vomiting'
			IndXraySFx='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: skull fracture on x-ray'
			IndOth='If a CT is being ordered or obtained check the most important indications in influencing the decision to obtain a head CT: other'
			CTSed='Was patient given or will patient be given pharmacological sedation for head CT scan?'
			CTSedAgitate='Reason for pharmacological sedation: agitation/inability to hold still'
			CTSedAge='Reason for pharmacological sedation: young age'
			CTSedRqst='Reason for pharmacological sedation: CT technician request'
			CTSedOth='Reason for pharmacological sedation: other '
			AgeInMonth='Age in months'
			AgeinYears='Age in years'
			AgeTwoPlus='Age: < 2 years'
			Gender='Gender'
			Ethnicity='Ethnicity'
			Race='Race'
			Observed="Was the patient observed in the ED after the physician's initial ED evaluation to determine whether to obtain head CT?"
			EDDisposition='ED Disposition'
			CTDone='Any head CT performed?'
			EDCT='Head CT performed in ED'
			PosCT='TBI on CT (determined by PI)'
			Finding1='Traumatic finding: cerebellar hemorrhage'
			Finding2='Traumatic finding: cerebral contusion'
			Finding3='Traumatic finding: cerebral edema'
			Finding4='Traumatic finding: cerebral hemorrhage/intracerebral hematoma'
			Finding5='Traumatic finding: diastasis of the skull'
			Finding6='Traumatic finding: epidural hematoma'
			Finding7='Traumatic finding: extra-axial hematoma'
			Finding8='Traumatic finding: intraventricular hemorrhage'
			Finding9='Traumatic finding: midline shift/shift of brain structures'
			Finding10='Traumatic finding: pneumocephalus'
			Finding11='Traumatic finding: skull fracture'
			Finding12='Traumatic finding: subarachnoid hemorrhage'
			Finding13='Traumatic finding: subdural hematoma'
			Finding14='Traumatic finding: traumatic infarction'
			Finding20='Traumatic finding (extra finding by PI): diffuse axonal injury'
			Finding21='Traumatic finding (extra finding by PI): herniation'
			Finding22='Traumatic finding (extra finding by PI):shear injury'
			Finding23='Traumatic finding (extra finding by PI): sigmoid sinus thrombosis'
			DeathTBI='Death due to TBI'
			HospHead='Hospitalized for 2 or more nights due to head injury'
			HospHeadPosCT='Hospitalized for 2 or more nights due to head injury and had TBI on CT'
			Intub24Head='Intubated  greater than 24 hours for head trauma'
			Neurosurgery='Neurosurgery'
			PosIntFinal='Clinically-important traumatic brain injury'
		;
run;
