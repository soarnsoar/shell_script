ARR_PROC_INTER=(\
#dyellell012j_5f_NLO_FXFX \
#dyellell01j_5f_NLO_FXFX \
#dyellell01234j_5f_LO_MLM \
#dyellell01234j_5f_LO_MLM_pdfwgt_T \
#dyellell012j_5f_LO_MLM \
#dyellell012j_5f_LO_MLM_pdfwgt_T \
)


for proc in ${ARR_PROC_INTER[@]};do
    echo "${proc} INTERACTIVE MODE"
    source gridpack_generation.sh ${proc} mycard/${proc}/ &> ${proc}.debug &

done

ARR_PROC_CONDOR=(\
#dyellell012j_5f_NLO_FXFX \
#dyellell01j_5f_NLO_FXFX \
#dyellell012j_5f_LO_MLM \
#dyellell012j_5f_LO_MLM_pdfwgt_T \
#dyellell01234j_5f_LO_MLM \
#dyellell01234j_5f_LO_MLM_pdfwgt_T \
)


for proc in ${ARR_PROC_CONDOR[@]};do
    echo "${proc} CONDOR"
    #source submit_condor_gridpack_generation.sh ${proc} mycard/${proc}/ &> ${proc}.debug&
    

done

ARR_PROC_CMSCON=(\
dyellell012j_5f_NLO_FXFX \
dyellell01j_5f_NLO_FXFX \
dyellell012j_5f_LO_MLM \
dyellell012j_5f_LO_MLM_pdfwgt_T \
dyellell01234j_5f_LO_MLM \
dyellell01234j_5f_LO_MLM_pdfwgt_T \
)
for proc in ${ARR_PROC_CMSCON[@]};do
    echo "${proc} CMSCON"
    #source submit_condor_gridpack_generation.sh ${proc} mycard/${proc}/ &> ${proc}.debug&                                                                                  
    #nohup ./submit_cmsconnect_gridpack_generation.sh PROCESSNAME CARDDIR > LOGNAME.debug 2>&1 &
    nohup ./submit_cmsconnect_gridpack_generation.sh ${proc} mycard/${proc}/ > ${proc}.debug 2>&1 &
done
