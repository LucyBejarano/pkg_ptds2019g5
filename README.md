# Programming Tools in Data Science Semester project : Application for Air Pollutants Analysis in Switzerland
Anna Alfieri, Ana Lucy Bejarano Montalvo, Clement Perez, Erika Lardo, Saphir Kwan

## Description

This repository contains a project based in the UNIL course Programming tools in Data Science given by S. Orso and I.Rudnytskyi. The aim through this work is to apply the tools learned in class and to propose a new visualization tool for an application

Given the current state of concern about the environmental issue, we have sought to make visual the measurements of the concentration of pollutants in the air in Switzerland in order to make these data understandable to a wider public.

The package contains severals function that provides a visual representation in various formats of the concentration of six pollutants (CO, NO2, O3, PM10, SO2, PM2.5) in several cities of Switzerland. 

Through an interactive **ShinyApp** are displayed : 
* timeplots by localisation and pollutant
* a barplot by pollutant
* a calendar per pollutant that shows the average concentration per day
* two calendars representing the average temperature and precipitation per day
* an information page about these pollutant including a table with the swiss limit regulation.
  
Aditionally, we give to the user the opportunity of analyse the latest data using our **ShinyApp**. To do so, the user can download the updated data in the official webside on the following link: https://www.bafu.admin.ch/bafu/en/home/topics/air/state/data/data-query-nabel.html .After dowloading the data, the user only has to copy and run the copy_me.R document found in this repository indicating the path where the new data is located.  

## Video Presentation

In order to help you understand how our project works, you can look at this video demonstrating the application's key points : https://www.youtube.com/watch?v=tDroKLXlEnU&feature=youtu.be

## Main references

For the realization of this project we used many resources on the internet such as the following which have been very valuable to us:
- M. Beckman, S. Guerrier, J. Lee, R. Molinari & S. Orso : An Introduction to Statistical Programming Methods with R (2019-09-30) https://smac-group.github.io/ds/ 
- Carslaw, David. Main Openair website: open source tools for air quality data analysis https://github.com/davidcarslaw/openair
- Swiss Confederation Data query NABEL https://www.bafu.admin.ch/bafu/en/home/topics/air/state/data/data-query-nabel.html
- Pollutants Swiss Limit Regulation https://www.swisstph.ch/fileadmin/user_upload/SwissTPH/Institute/Ludok/immissionGW_d.pdf
- I. Rudnytskyi : Managing dependencies in packages https://www.r-bloggers.com/%F0%9F%93%A6-managing-dependencies-in-packages/ 

## License
The content of this project is licensed under the GNU General Public License.
