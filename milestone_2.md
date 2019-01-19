# Wine Review Milestone 2

Contributors: Milos Milic and Betty Zhou

## 1. Rationale

Our Rationale for designing this app was to provide an easy to use interactive tool for a user (i.e. an institutional customer like a restaurant owner or an individual customer) to find potential wines within their budget and rating criteria. Since the intended purpose of the app is to help the user decide on new wines based on price and rating, we believe it is the most important to provide a count distribution of wines based on user selected budget and rating. Therefore, we implemented a price and rating slider that will update the count distibutions of price or rating based on user inputs. In summary, we designed three sections in our app: the slider section on the left panel, tabs to toggle between the price distribution and rating distribution on the upper main panel, and the summary table on the lower main panel.

## 2. Tasks

We had Three Broad tasks for our Milestone 2:

##### Build correct sliders
  - We implemented a rating slider and a price slider for users to filter the dataset.
  ![](/img/slider.PNG "rating distribution")

##### Have the tabs implemented
  - We added two tabs in the main panel of the app to allow the user to toggle between the rating distribution or price distribution.
  ![](/img/tab.PNG "rating distribution")

##### Have the correct table information shown
  - The original dataset had many superfluous columns that did not need to be shown to the user and needed to be removed. We just wanted to show: __Price, Rating, Country, Province, Variety, Title, Name of Rater, Description__.

  - The rows in the table are filtered based on user specified price and rating, we wanted to have more options for the user to filter out the subset of wines they collected. Therefore, we added search boxes below each column of the table for the user to further filter the results.
![dashBoard](/img/table.PNG "price distribution")

## 3 Vision and Next Steps

Ultimately, we wanted to have a rather intuitive user interface for filtering out wines based on price and rating. We had proposed to include a map to display the counts of wines for different countries in the filter results, but we carried forward with count distributions instead because distributions would be more informative for our intended user who are searching for potential wines within a certain budget and rating. Even though the map would not be the most informative for our user, a map displaying the counts of wines for different countries would be a nice visual of the filter results. Therefore, given time, we would like to implement the map.

## 4. Bugs

So far, we have not come across any bugs.
