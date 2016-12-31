---
title: "Codebook for coursera getting and cleaning data project"
output: github_document
---

#Codebook

##Codebook for Getting and cleaning data course project
_By: Leo Timmermans_  
_Submission date: december 31, 2016_

##Source
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Luca Oneto(1) and Xavier Parra(2)  
1 - Smartlab, DIBRIS - Universit???  degli Studi di Genova, Genoa (16145), Italy.  
2 - CETpD - Universitat Politècnica de Catalunya. Vilanova i la Geltrú (08800), Spain
har '@' smartlab.ws  
www.smartlab.ws

##Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

This dataset is a derived dataset containing only the mean of the mean and the standard deviation of each measurement.

*EXTENT OF COLLECTION:*  1 file ("TidyDataSet.txt") containing the mean of the mean and standard deviation of each measurement from 30 subject for 6 activities.

*DATA FORMAT:* text

##Codebook


Variable name | Range | Type of variable | Values or explanation
--------------|-------|------------------|-----------------------
subjectid | 1-30 | integer | unique number identifying the participant in the experiment
activity |  | factor | name of activity performed

All variables below respresent the mean of mean and standard deviation for the given subject and activity.
All variables are numberic and fall between -1 and 1.
Explanation of words that form the variable name:  
- time = time domain signal  
- frequency = frequency domain signal  
- body = body acceleration signal  
- gravity = gravity acceleration signal 
- accelerometer = measured by accelerometer  
- gyroscope = measured by gyroscope  
- jerk = sudden movement acceleration  
- magnitude = magnitude of acceleration  
All variables end with following parts:  
- mean = mean value of measurements  
- std() = standard deviation of measurements  
- x = x-axis measurements  
- y = y-axis measurements  
- z = z-axis measurements

Units:  
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).  
- The gyroscope units are rad/seg.


_*Variables*_  
timebodyaccelerometermeanx  
timebodyaccelerometermeany  
timebodyaccelerometermeanz  
timebodyaccelerometerstdx  
timebodyaccelerometerstdy  
timebodyaccelerometerstdz  
timegravityaccelerometermeanx  
timegravityaccelerometermeany  
timegravityaccelerometermeanz  
timegravityaccelerometerstdx  
timegravityaccelerometerstdy  
timegravityaccelerometerstdz  
timebodyaccelerometerjerkmeanx  
timebodyaccelerometerjerkmeany  
timebodyaccelerometerjerkmeanz  
timebodyaccelerometerjerkstdx  
timebodyaccelerometerjerkstdy  
timebodyaccelerometerjerkstdz  
timebodygyroscopemeanx  
timebodygyroscopemeany  
timebodygyroscopemeanz  
timebodygyroscopestdx  
timebodygyroscopestdy  
timebodygyroscopestdz  
timebodygyroscopejerkmeanx  
timebodygyroscopejerkmeany  
timebodygyroscopejerkmeanz  
timebodygyroscopejerkstdx  
timebodygyroscopejerkstdy  
timebodygyroscopejerkstdz  
timebodyaccelerometermagnitudemean  
timebodyaccelerometermagnitudestd  
timegravityaccelerometermagnitudemean  
timegravityaccelerometermagnitudestd  
timebodyaccelerometerjerkmagnitudemean  
timebodyaccelerometerjerkmagnitudestd  
timebodygyroscopemagnitudemean  
timebodygyroscopemagnitudestd  
timebodygyroscopejerkmagnitudemean  
timebodygyroscopejerkmagnitudestd  
frequencybodyaccelerometermeanx  
frequencybodyaccelerometermeany  
frequencybodyaccelerometermeanz  
frequencybodyaccelerometerstdx  
frequencybodyaccelerometerstdy  
frequencybodyaccelerometerstdz  
frequencybodyaccelerometerjerkmeanx  
frequencybodyaccelerometerjerkmeany  
frequencybodyaccelerometerjerkmeanz  
frequencybodyaccelerometerjerkstdx  
frequencybodyaccelerometerjerkstdy  
frequencybodyaccelerometerjerkstdz  
frequencybodygyroscopemeanx  
frequencybodygyroscopemeany  
frequencybodygyroscopemeanz  
frequencybodygyroscopestdx  
frequencybodygyroscopestdy  
frequencybodygyroscopestdz  
frequencybodyaccelerometermagnitudemean  
frequencybodyaccelerometermagnitudestd  
frequencybodyaccelerometerjerkmagnitudemean  
frequencybodyaccelerometerjerkmagnitudestd  
frequencybodygyroscopemagnitudemean  
frequencybodygyroscopemagnitudestd  
frequencybodygyroscopejerkmagnitudemean  
frequencybodygyroscopejerkmagnitudestd


####Notes  
A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: http://www.youtube.com/watch?v=XOEN9W05_4A
For more information about this dataset please contact: activityrecognition '@' smartlab.ws

####Original publication  
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.