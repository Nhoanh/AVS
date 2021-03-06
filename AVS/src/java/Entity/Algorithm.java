/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

/**
 *
 * @author Jisoo
 */
public class Algorithm {
    private int algoID;
    private String algoName;
    private String algoCodeJava;
    private String algoCodeCplus;
    private String algoCodeJS;
    private String algoCodeVisual;
    private String algoDescription;
    private int categoryID;
    private String algoDatetime;
    private String algoResource;
    private int number_of_step;
    private String categoryName;
    private String algoFile;
    private int visualized;
    private int deleted;
   
    public Algorithm() {
        
    }

    public int getNumber_of_step() {
        return number_of_step;
    }

    public void setNumber_of_step(int number_of_step) {
        this.number_of_step = number_of_step;
    }

    public Algorithm(int algoID, String algoName, String algoCodeJava, String algoCodeCplus, String algoCodeJS, String algoDescription, int categoryID, String algoDatetime, String algoResource, int number_of_step) {
        this.algoID = algoID;
        this.algoName = algoName;
        this.algoCodeJava = algoCodeJava;
        this.algoCodeCplus = algoCodeCplus;
        this.algoCodeJS = algoCodeJS;
        this.algoDescription = algoDescription;
        this.categoryID = categoryID;
        this.algoDatetime = algoDatetime;
        this.algoResource = algoResource;
        this.number_of_step = number_of_step;
    }

    public Algorithm(int algoID, String algoName, String algoCodeJava, String algoCodeCplus, String algoCodeJS, String algoCodeVisual, String algoDescription, int categoryID, String algoDatetime, String algoResource, String categoryName, String algoFile, int visualized) {
        this.algoID = algoID;
        this.algoName = algoName;
        this.algoCodeJava = algoCodeJava;
        this.algoCodeCplus = algoCodeCplus;
        this.algoCodeJS = algoCodeJS;
        this.algoCodeVisual = algoCodeVisual;
        this.algoDescription = algoDescription;
        this.categoryID = categoryID;
        this.algoDatetime = algoDatetime;
        this.algoResource = algoResource;      
        this.categoryName = categoryName;
        this.algoFile = algoFile;
        this.visualized = visualized;
    }
  
    
  

    public String getAlgoFile() {
        return algoFile;
    }

    public void setAlgoFile(String algoFile) {
        this.algoFile = algoFile;
    }
    
    

    public int getAlgoID() {
        return algoID;
    }

    public void setAlgoID(int algoID) {
        this.algoID = algoID;
    }

    public String getAlgoName() {
        return algoName;
    }

    public void setAlgoName(String algoName) {
        this.algoName = algoName;
    }

    public String getAlgoCodeJava() {
        return algoCodeJava;
    }

    public void setAlgoCodeJava(String algoCodeJava) {
        this.algoCodeJava = algoCodeJava;
    }

    public String getAlgoCodeCplus() {
        return algoCodeCplus;
    }

    public void setAlgoCodeCplus(String algoCodeCplus) {
        this.algoCodeCplus = algoCodeCplus;
    }

    public String getAlgoCodeJS() {
        return algoCodeJS;
    }

    public String getAlgoCodeVisual() {
        return algoCodeVisual;
    }

    public void setAlgoCodeVisual(String algoCodeVisual) {
        this.algoCodeVisual = algoCodeVisual;
    }

    public void setAlgoCodeJS(String algoCodeJS) {
        this.algoCodeJS = algoCodeJS;
    }

    public String getAlgoDescription() {
        return algoDescription;
    }

    public void setAlgoDescription(String algoDescription) {
        this.algoDescription = algoDescription;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getAlgoDatetime() {
        return algoDatetime;
    }

    public void setAlgoDatetime(String algoDatetime) {
        this.algoDatetime = algoDatetime;
    }

    public String getAlgoResource() {
        return algoResource;
    }

    public void setAlgoResource(String algoResource) {
        this.algoResource = algoResource;
    }

    public String getCategoryNametoString() {
        int sortid = 1;
        int searchid = 2;
        if(this.categoryID == sortid) {
            return "Sort";
        }
        if(this.categoryID == searchid) {
            return "Search";
        }
        return "Other";
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getVisualizedToString() {
        if(visualized==1) {
            return "Yes";
        }
        else { 
            return "No";
        }
    }

    public void setVisualized(int visualized) {
        this.visualized = visualized;
    }

    public int getVisualized() {
        return visualized;
    }

    public int getDeleted() {
        return deleted;
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }
    
    
}
