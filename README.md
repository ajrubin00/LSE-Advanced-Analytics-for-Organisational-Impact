<h1>Course 3: Advanced Analytics for Organisational Impact</h1>
  <h3>April 2023</h3>

Grade: 85% (Distinction)
<h2>Context</h2>
  <p>
  Turtle Games (TG) is a (fictional) game manufacturer and retailer with a global customer base, operating in North America and Europe. It manufactures and sells its own products and those made by other companies, including books, board games, video games, and toys. 
    
  The company collects data from sales as well as customer reviews. TG has a business objective of improving overall sales performance by analysing data on its customers and sales figures. 

In terms of its customers, TG would like to understand how customers accumulate 'loyalty points', how groups within the customer base can be used to target specific market segments and how social data (customer reviews) can be used to inform marketing campaigns. 

In terms of sales, TG would like to understand the impact that each product has on sales, the reliability of its sales data and the relationship between North American, European and Global sales. 
</p>

<h2>Analytical Approach</h2>
<p>
  <b>Marketing Data</b>

TG’s marketing department provided quantitative and qualitative data gathered from 2000 customers. The quantitative portion of this data comprised information on customers’ remuneration, spending score, loyalty points. The qualitative data comprised textual game reviews and summaries. Python was used to analyse the customer dataset, along with the libraries Pandas, used to import and clean the data, Numpy used for additional data manipulation capabilities, Sklearn for more advanced analytical techniques such as machine learning and nltk for processing qualitative data used natural language processing techniques. Data was imported into Python and cleaned to address missing values, duplicates, inconsistent data types and to remove unnecessary columns. Thereafter, three primary analyses were performed in Python: 

Simple and Multiple linear regression was used to investigate how loyalty points might be impacted by spending scores, age and remuneration.  
K-Means clustering was used to understand how the customer base might be segmented for market targeting.
Natural Language Processing (NLP) was used to analyse customer reviews to help inform marketing campaigns. 

<b>Sales Data</b>

TG's sales data on 352 different games, the platforms on which they are played and their respective North American (NA), European (EU) and global sales was analysed using R. The tidyverse and dplyr libraries were used to import and clean the data by addressing missing values and removing unnecessary columns. Three primary analyses were conducted in R:

Initial Exploratory Data Analysis was conducted to examine the distribution of sales data across different regions and platforms and to determine the impact that each product has on sales. 
Normality testing was used to assess the reliability of the sales data. 
Regression analysis was used to investigate the relationships between NA, EU and global sales. 
</p>
<h2>Visualisation and Insights</h2>
<p>
  Regression was performed to assess the impact of spending score, remuneration and age, individually and collectively, on loyalty points. Scatterplots were used to depict the strength and direction of the relationships, and to assess model accuracy. Spending score, remuneration and age all have significant positive relationships with loyalty points, meaning that customers who are older, have higher incomes or have higher spending scores are more likely to have accumulated higher numbers of loyalty points. 

  ![image](https://github.com/AsafRubin00/Rubin_Asaf_DA301_Assignment/assets/115939423/035f8a17-ff86-4331-b922-03aee126f64e)

  K-Means clustering was used to segment the customer base into five distinct groups (clusters), based on their remuneration and spending scores. The distribution of these clusters was visualized on a scatterplot to help inform targeted strategies for each segment. For example, TG could prioritize high-value customers with incentives and implement loyalty programs for more moderate spenders.

  ![image](https://github.com/AsafRubin00/Rubin_Asaf_DA301_Assignment/assets/115939423/135ec11b-0c80-4871-9a10-01ba50548af2)

  NLP techniques were used to analyse customer reviews, identifying frequently used words (visualised in word clouds), and sentiment and subjectivity scores. The results of the sentiment analysis were plotted on a histogram, showing that most reviews are more positive than negative. Reviews were also analysed to assess subjectivity, and plotted on histograms, showing that most reviews are a mix of subjective and objective.

  ![image](https://github.com/AsafRubin00/Rubin_Asaf_DA301_Assignment/assets/115939423/83f67671-7bfc-4f8e-966b-890a8551341f)
  ![image](https://github.com/AsafRubin00/Rubin_Asaf_DA301_Assignment/assets/115939423/7e5f0ab3-c905-41a3-a545-d9705a485c6a)
  ![image](https://github.com/AsafRubin00/Rubin_Asaf_DA301_Assignment/assets/115939423/32275c0f-8d26-40b1-be25-2a06d6f15260)
  ![image](https://github.com/AsafRubin00/Rubin_Asaf_DA301_Assignment/assets/115939423/e4414104-d68b-4f0e-881f-a07bff06c62c)

  An initial exploratory data analysis was performed to examine distribution of sales data across different regions and platforms. The top 10 highest and lowest selling products in each region were identified and visualized on bar plots.

![image](https://github.com/AsafRubin00/Rubin_Asaf_DA301_Assignment/assets/115939423/b8c96fb1-5cae-441c-9700-8b7c2f907c08)
![image](https://github.com/AsafRubin00/Rubin_Asaf_DA301_Assignment/assets/115939423/ee003099-686d-4d8d-8394-103321cd0b6e)

Sales data’s reliability was assessed with tests for normality and correlation analysis, revealing that there is a wide variation in sales performance for different products and that the data is not normally distributed. This suggests the presence of a few highly successful games, while the majority have modest sales.

![image](https://github.com/AsafRubin00/Rubin_Asaf_DA301_Assignment/assets/115939423/10a03355-ccbc-4c95-8ccc-54acd5123904)
![image](https://github.com/AsafRubin00/Rubin_Asaf_DA301_Assignment/assets/115939423/eac4519e-056d-41f9-acc9-1b7abfcecf1a)
![image](https://github.com/AsafRubin00/Rubin_Asaf_DA301_Assignment/assets/115939423/f951fea8-917b-4955-b6c4-1f29aa33863f)

Sales data was used to model regressions, and to make predictions based on sales values provided. NA sales were shown to be highly correlated with global sales. EU sales had a positive but weaker correlation with global sales. The regression models show reasonable predictions for global sales based on regional sales. However, further investigation showed that the model’s residuals are not normally distributed, which means that the predictions become less accurate for larger sales values, and should therefore be used with caution. 

![image](https://github.com/AsafRubin00/Rubin_Asaf_DA301_Assignment/assets/115939423/2019ed5a-830b-43cf-b84e-a7b79c5cfe8c)
</p>

<h2>Patterns and Predictions</h2>
<p>
The results of the analysis suggest 6 key findings most relevant to TG’s objectives:

Spending score, remuneration and age account for 84.4% of the variance in loyalty points. This means as a customer’s age, remuneration or spending score increases, as do their loyalty points. However, the non-linear relationship between variables means that the results of this analysis should be used with caution. 
TG’s customer base has five distinct clusters, based on remuneration and spending scores. TG can optimize marketing efforts, drive business growth, and enhance customer satisfaction by tailoring strategies for each segment. For example, TG can prioritize high-value customers with incentives, create loyalty programs for moderate spenders, and explore cost-effective engagement for low-income segments.
Most customer reviews are generally positive. Some of the most positive reviews include words such as “awesome” and “excellent”, while some of the most negative include “boring”, “difficult” and “disappointed”. 
TG has several top selling games that significantly outperform others and a larger number that sell moderately or low.
TG’s sales data is not normally distributed, with wide variety in sales performance. The sales data analysis should be treated with caution and it is recommended that more data be collected and analysed to produce more reliable results to inform decision-making. 
91.99% of the variance in global sales can be explained by NA and EU sales, meaning that as NA and EU sales increase, as do global sales. 
  
</p>
