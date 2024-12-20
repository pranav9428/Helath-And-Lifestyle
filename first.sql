/*1. Retrieve the count of individuals grouped by gender in the Sleep_health_and_lifestyle_dataset.*/\
select gender, Count(*) as individualcount
from finalproject.sleep_health_and_lifestyle_dataset
group by gender;

 /*2.Find the average sleep quality for each occupation from the Sleep_health_and_lifestyle_dataset.*/
select Occupation, avg(QualityofSleep) as QualityofSleepavg
from finalproject.sleep_health_and_lifestyle_dataset
group by Occupation;

/*3. Identify the individuals with stress levels greater than 7 and physical activity levels below 30 in the Sleep_health_and_lifestyle_dataset.*/
select PersonID,Gender,Age,Occupation,SleepDuration,PhysicalActivityLevel
from finalproject.sleep_health_and_lifestyle_dataset
where StressLevel >7
and StressLevel <30;

/*4.Calculate the average insurance charges for smokers and non-smokers from the insurance dataset.*/
select smoker ,avg(charges) as avgcharges
from finalproject.insurance
group by smoker;

/*5.Compare the average BMI of individuals in age groups (18-30, 31-50, 51+) from the insurance dataset.*/
SELECT 
CASE 
WHEN age BETWEEN 18 AND 30 THEN '18-30'
WHEN age BETWEEN 31 AND 50 THEN '31-50'
WHEN age > 50 THEN '51+'
END AS Age_Group,
AVG(bmi) AS Average_BMI
FROM finalproject.insurance
GROUP BY Age_Group;

/*6.Retrieve the region with the highest average insurance charges from the insurance dataset.*/
select region , AVG (charges) as highcharges
from finalproject.insurance
group by region 
order by highcharges desc limit 1;

/*7.Find the average sleep duration for each BMI category in the Sleep_health_and_lifestyle_dataset.*/
select BMI_Category ,AVG(SleepDuration) AS AVGSleepDuration
from finalproject.sleep_health_and_lifestyle_dataset
group by BMI_Category;

/*8.Combine both datasets to list individuals (based on age and gender) who are smokers, have a BMI over 30, and report stress levels higher than */
SELECT i.age, i.sex, s.PersonID, s.Occupation, s.StressLevel, i.bmi, i.smoker
FROM finalproject.insurance i
JOIN finalproject.Sleep_health_and_lifestyle_dataset s
ON i.age = s.Age AND i.sex = s.Gender
WHERE 
    i.smoker = 'yes' 
    AND i.bmi > 30 
    AND s.StressLevel > 8;

/*9.Classify individuals into age groups (18-30, 31-50, 51+) and retrieve the count of individuals in each group.*/
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 30 THEN '18-30'
        WHEN Age BETWEEN 31 AND 50 THEN '31-50'
        ELSE '51+'
    END AS Age_Group,
    COUNT(*) AS Individual_Count
FROM 
    Sleep_health_and_lifestyle_dataset
GROUP BY 
    Age_Group;

/*10. Classify sleep quality into "Poor" (0-3), "Moderate" (4-6), "Good" (7-10) and find the count for each.*/
SELECT 
    CASE 
        WHEN QualityofSleep BETWEEN 0 AND 3 THEN 'Poor'
        WHEN QualityofSleep BETWEEN 4 AND 6 THEN 'Moderate'
        ELSE 'Good'
    END AS Sleep_Quality_Category,
    COUNT(*) AS Individual_Count
FROM 
    Sleep_health_and_lifestyle_dataset
GROUP BY 
    Sleep_Quality_Category;
    
/*11.Classify BMI into "Underweight" (<18.5), "Normal" (18.5-24.9), "Overweight" (25-29.9), and "Obese" (30+) and count individuals in each category.*/
    SELECT 
    CASE 
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal'
        WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
        ELSE 'Obese'
    END AS BMI_Category,
    COUNT(*) AS Individual_Count
FROM 
    insurance
GROUP BY 
    BMI_Category;

/*12.Classify stress levels into "Low" (0-3), "Moderate" (4-6), and "High" (7-10) and calculate average physical activity levels. 	*/
SELECT 
    CASE 
        WHEN StressLevel BETWEEN 0 AND 3 THEN 'Low'
        WHEN StressLevel BETWEEN 4 AND 6 THEN 'Moderate'
        ELSE 'High'
    END AS Stress_Level_Category,
    AVG(PhysicalActivityLevel) AS Average_Physical_Activity
FROM 
    Sleep_health_and_lifestyle_dataset
GROUP BY 
    Stress_Level_Category;

/*13.Classify individuals into age groups (18-30, 31-50, 51+) and calculate the average insurance charges for each group.*/
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 50 THEN '31-50'
        ELSE '51+'
    END AS Age_Group,
    AVG(charges) AS Average_Insurance_Charges
FROM 
    insurance
GROUP BY 
    Age_Group;
/*14.Classify physical activity levels into "Sedentary" (<30), "Moderately Active" (30-60), and "Active" (>60).*/
SELECT 
    CASE 
        WHEN PhysicalActivityLevel < 30 THEN 'Sedentary'
        WHEN PhysicalActivityLevel BETWEEN 30 AND 60 THEN 'Moderately Active'
        ELSE 'Active'
    END AS Activity_Level,
    COUNT(*) AS Individual_Count
FROM 
    Sleep_health_and_lifestyle_dataset
GROUP BY 
    Activity_Level;
/*15.Classify individuals into insurance risk categories based on smoking status and BMI
            "High Risk" (Smoker + BMI > 30)
            "Medium Risk" (Non-Smoker + BMI > 30) 
             "Low Risk" (BMI <= 30).
*/
SELECT 
    CASE 
        WHEN smoker = 'yes' AND bmi > 30 THEN 'High Risk'
        WHEN smoker = 'no' AND bmi > 30 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Category,
    COUNT(*) AS Individual_Count
FROM 
    insurance
GROUP BY 
    Risk_Category;

/*16. Classify individuals as having or not having sleep disorders and calculate their average daily steps.*/
SELECT 
    CASE 
        WHEN SleepDisorder = 'None' THEN 'Without Sleep Disorder'
        ELSE 'With Sleep Disorder'
    END AS SleepDisorder,
    AVG(DailySteps) AS Average_Daily_Steps
FROM 
    Sleep_health_and_lifestyle_dataset
GROUP BY 
    SleepDisorder;

/*17. Classify individuals with children into discount categories and calculate their average insurance charges:

	        "No Discount" (0 children)
		"Basic Discount" (1 child)
		"Standard Discount" (2 children)
		"Premium Discount" (3+ children).
*/
SELECT 
    CASE 
        WHEN children = 0 THEN 'No Discount'
        WHEN children = 1 THEN 'Basic Discount'
        WHEN children = 2 THEN 'Standard Discount'
        ELSE 'Premium Discount'
    END AS Discount_Category,
    AVG(charges) AS Average_Insurance_Charges
FROM 
    insurance
GROUP BY 
    Discount_Category;

/*18.Classify individuals into risk profiles based on stress levels and sleep quality:

		"High Risk" (Stress > 7 and Sleep Quality < 4)
		"Moderate Risk" (Stress 4-7 and Sleep Quality 4-7)
		"Low Risk" (Stress <= 3 and Sleep Quality > 7).
*/
SELECT 
    CASE 
        WHEN StressLevel > 7 AND QualityofSleep < 4 THEN 'High Risk'
        WHEN StressLevel BETWEEN 4 AND 7 AND QualityofSleep BETWEEN 4 AND 7 THEN 'Moderate Risk'
        ELSE 'Low Risk'
    END AS Risk_Profile,
    COUNT(*) AS Individual_Count
FROM 
    Sleep_health_and_lifestyle_dataset
GROUP BY 
    Risk_Profile;

/*19.List the average insurance charges for individuals grouped by gender from the Sleep_health_and_lifestyle_dataset.*/
WITH GenderData AS (
    SELECT Gender, Age FROM Sleep_health_and_lifestyle_dataset
)
SELECT 
    g.Gender, 
    AVG(i.charges) AS Average_Insurance_Charges
FROM 
    GenderData g
JOIN 
    insurance i
ON 
    g.Age = i.age
GROUP BY 
    g.Gender;
