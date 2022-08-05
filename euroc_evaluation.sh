#!/bin/bash
pathDatasetEuroc='../Datasets/EuRoc' #Example, it is necesary to change it by the dataset path

# # Single Session Example (Pure visual)
# echo "Launching MH01 with Stereo sensor"
# ./Examples/Stereo/stereo_euroc ./Vocabulary/ORBvoc.txt ./Examples/Stereo/EuRoC.yaml "$pathDatasetEuroc"/MH01 ./Examples/Stereo/EuRoC_TimeStamps/MH01.txt dataset-MH01_stereo
# echo "------------------------------------"
# echo "Evaluation of MH01 trajectory with Stereo sensor"
# python evaluation/evaluate_ate_scale.py evaluation/Ground_truth/EuRoC_left_cam/MH01_GT.txt f_dataset-MH01_stereo.txt --plot MH01_stereo.pdf



# # MultiSession Example (Pure visual)
# echo "Launching Machine Hall with Stereo sensor"
# ./Examples/Stereo/stereo_euroc ./Vocabulary/ORBvoc.txt ./Examples/Stereo/EuRoC.yaml "$pathDatasetEuroc"/MH01 ./Examples/Stereo/EuRoC_TimeStamps/MH01.txt "$pathDatasetEuroc"/MH02 ./Examples/Stereo/EuRoC_TimeStamps/MH02.txt "$pathDatasetEuroc"/MH03 ./Examples/Stereo/EuRoC_TimeStamps/MH03.txt "$pathDatasetEuroc"/MH04 ./Examples/Stereo/EuRoC_TimeStamps/MH04.txt "$pathDatasetEuroc"/MH05 ./Examples/Stereo/EuRoC_TimeStamps/MH05.txt dataset-MH01_to_MH05_stereo
# echo "------------------------------------"
# echo "Evaluation of MAchine Hall trajectory with Stereo sensor"
# python evaluation/evaluate_ate_scale.py evaluation/Ground_truth/EuRoC_left_cam/MH_GT.txt f_dataset-MH01_to_MH05_stereo.txt --plot MH01_to_MH05_stereo.pdf

array=( MH01 MH02 MH03 MH04 MH05 V101 V102 V103 V201 V202 V203 )

# Single Session Example (Visual-Inertial)
for i in "${array[@]}"
do
    for j in {1..10}
    do
        echo "Launching "$i" with Monocular-Inertial sensor"
        ./Examples/Monocular-Inertial/mono_inertial_euroc ./Vocabulary/ORBvoc.txt ./Examples/Monocular-Inertial/EuRoC.yaml "$pathDatasetEuroc"/"$i" ./Examples/Monocular-Inertial/EuRoC_TimeStamps/"$i".txt dataset-"$i"_monoi
        echo "------------------------------------"
        echo "Evaluation of "$i" trajectory with Monocular-Inertial sensor"
        python evaluation/evaluate_ate_scale.py "$pathDatasetEuroc"/"$i"/mav0/state_groundtruth_estimate0/data.csv f_dataset-"$i"_monoi.txt --plot "$i"_monoi.pdf --verbose --verbose2 --ds "$i"
        echo "------------------------------------"
    done
done

# MultiSession Monocular Examples

# echo "Launching Vicon Room 2 with Monocular-Inertial sensor"
# ./Examples/Monocular-Inertial/mono_inertial_euroc ./Vocabulary/ORBvoc.txt ./Examples/Monocular-Inertial/EuRoC.yaml "$pathDatasetEuroc"/V201 ./Examples/Monocular-Inertial/EuRoC_TimeStamps/V201.txt "$pathDatasetEuroc"/V202 ./Examples/Monocular-Inertial/EuRoC_TimeStamps/V202.txt "$pathDatasetEuroc"/V203 ./Examples/Monocular-Inertial/EuRoC_TimeStamps/V203.txt dataset-V201_to_V203_monoi
# echo "------------------------------------"
# echo "Evaluation of Vicon Room 2 trajectory with Stereo sensor"
# python evaluation/evaluate_ate_scale.py evaluation/Ground_truth/EuRoC_imu/V2_GT.txt f_dataset-V201_to_V203_monoi.txt --plot V201_to_V203_monoi.pdf
