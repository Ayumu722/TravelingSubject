#!/bin/sh

# Set variable values that locate and specify data to process
HomeDirectory="/home/denbo3/ayumu/BrainMINDSBeyond" # Location of Subject folders (named by subjectID)
DataFolder="${HomeDirectory}" # Location of Subject folders (named by subjectID)
DicomFolder="${HomeDirectory}/testdata_dicom" # Location of Subject folders (named by subjectID)
ScriptFolder="${HomeDirectory}/code" # Location of Subject folders (named by subjectID)
SubjData="${HomeDirectory}/participants.tsv"   # Space delimited list of subject IDs
Subjlist=$(cut -f 2 $SubjData | sed -e '1d')
Configfile="${ScriptFolder}/config.json"   # Space delimited list of subject IDs

job_dir="${ScriptFolder}/job"
script_output="${ScriptFolder}/out"
mkdir -p ${DataFolder}
mkdir -p ${script_output}
mkdir -p ${job_dir}

i=0
while read Subject; do
  Subject=`echo $Subject | sed -e "s/[\r\n]\+//g"`
  subnum=$(cat $SubjData | grep $Subject | awk '{print $11}')
  SubjectDataFolder=${DicomFolder}/${Subject}
  if [ ! -d $DataFolder/sourcedata/$subnum ]; then
  echo "#!/bin/sh" >${job_dir}/${Subject}.sh
  echo "#PBS -m e" >>${job_dir}/${Subject}.sh
  echo "#PBS -j oe" >>${job_dir}/${Subject}.sh
  echo "#PBS -o ${script_output}" >>${job_dir}/${Subject}.sh
  echo "cd $DataFolder/sourcedata" >>${job_dir}/${Subject}.sh
  echo "${HomeDirectory}/bin/dcm2bids -d ${SubjectDataFolder} -p $subnum -c ${Configfile}" >>${job_dir}/${Subject}.sh
  fi
  i=$(($i+1))
done <<END
$Subjlist
END

