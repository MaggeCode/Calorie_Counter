# Load all the required packages
library(ggplot2)
library(scales)
library(dplyr)
library(gridExtra)

# Preload the csv data
cal_data <- read.csv("https://raw.githubusercontent.com/MaggeCode/HSG/main/calory_Data4.csv")
str(cal_data)

# Graph 1: Create a pie chart with the gender distribution. 
    # Create subsets by counting the rows including female or male
    m = nrow(subset(cal_data, Gender=="male"))     
    f = nrow(subset(cal_data, Gender=="female"))     
    
    # Create a data frame for the pie chart
    data <- data.frame(
      gender= c("male","female"),
      gender_count=c(m,f)
    )
    
    # Compute the position of labels
    data <- data %>% 
      arrange(desc(gender)) %>%
      mutate(prop = gender_count / sum(data$gender_count) *100) %>%
      mutate(ypos = cumsum(prop)- 0.5*prop )
    
    # Create the piechart
    p4 <- ggplot(data, aes(x="", y=prop, fill=gender)) +
      geom_bar(stat="identity", width=1, color="white") +
      coord_polar("y", start=0) +
      theme_void() + 
    
      
    # Add labels to the pie chart  
      geom_text(aes(y = ypos, label = gender_count), color = "black", size=6) +
      scale_fill_brewer(palette="Set1")+
    
    # Add title
      labs(title="Quantity of female and male inputs")

  
# Graph 2: Create a pie chart about how the quantity chosen from each product

    # Calculate the sum for each product
    Ham<- sum(cal_data$Hamburger)
    Che<- sum(cal_data$Cheese.Burger)
    Big<- sum(cal_data$Big.Mac)
    McC<- sum(cal_data$McChicken)
    Fre<- sum(cal_data$French.Fries)
    Sal<- sum(cal_data$Salad)
    Coc<- sum(cal_data$Coca.Cola)
    Spr<- sum(cal_data$Sprite)
    
    # Create data frame for the piechart
    data <- data.frame(
      product= c("Hamburger","Cheese burger","Big Mac","McChicken","French Fries","Salad","Coca Cola","Sprite"),
      value=c(Ham,Che,Big,McC,Fre,Sal,Coc,Spr)
    )
    
    # Compute the position of labels
    data <- data %>% 
      arrange(desc(product)) %>%
      mutate(prop = value / sum(data$value) *100) %>%
      mutate(ypos = cumsum(prop)- 0.5*prop )
    
    # Create the piechart
    p3 <- ggplot(data, aes(x="", y=prop, fill=product)) +
      geom_bar(stat="identity", width=1, color="white") +
      coord_polar("y", start=0) +
      theme_void() + 
       
    # Add labels to the pie chart  
      geom_text(aes(y = ypos, label = value), color = "black", size=4) +
      scale_fill_brewer(palette="Set2")+
      #add title
      labs(title="Quantity of each product chosen")


# Graph 3: Create a chart showing the calories inputs per age
    p1 <- ggplot(data = cal_data, aes(y = Total.Calories , x = Age)) + 
      geom_point(alpha = 0.5)+  
      geom_smooth(span = 0.7,se = FALSE)+
      labs(title="Calorie inputs per age")
 

# Graph 4: Create a chart showing what people chose compared to recommended calories per meal and day, from the last 20 inputs
  
    # Choose last 20 entries of the data set. Choose the rownames and the calories and store them in a vector each.
    last_20_rownames <- c(rownames(tail(cal_data, 20)))
    last_20_cal <- c(tail(cal_data$Total.Calories, 20))
    
    # Create data frame to prepare for the graph
    last_20_frame <- data.frame(last_20_rownames, last_20_cal)
  
    # Create the graph with ggplot including one bar chart and two line graphs.
    p2 <- ggplot(last_20_frame) +
    geom_col(aes(x = last_20_rownames, y = last_20_cal), size = 1, color = "grey", fill = "white")+
    geom_line(aes(x = last_20_rownames, y = rec_cal_meal_f), size = 1.5, color="red", group = 1)+
    geom_line(aes(x = last_20_rownames, y = rec_cal_meal_m), size = 1.5, color=("#0066CC"), group = 1)+
    labs(title="Last inputs compared to recommended calories per meal (f/m)")+
      labs(y= "calories per meal", x = "Last 20 entries")


# Create a style scheme for the graph titles
  My_Theme = theme(
    title=element_text(size=8,face="bold"))

# Create a dashboard with all graphs presented at the same time using the gridExtra package     
  require(gridExtra)
  grid.arrange(p4+My_Theme, p3+My_Theme, p2+My_Theme, p1+My_Theme,  ncol=2, nrow=2)



  


  
 



