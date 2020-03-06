theCountry=$1
echo "Country, $theCountry" > covid19$theCountry.csv
for dt in $(seq -w 1 60)
do
    theDay=$(date -d "2020-02-20 +$dt days" +%m-%d-%Y)
    echo $theDay    

    #curl "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/$theDay.csv" 2>/dev/null | awk -F"," '/${theCountry}/{printf ("%s/%s/%s,%s,%s\n", substr($3,9,2), substr($3,6,2), substr($3,1,4),$4,$5) }' >> coviditalia.csv


    curl "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/$theDay.csv" 2>/dev/null | awk -v pat="$theCountry" -F"," '$0~pat{printf ("%s/%s/%s,%s,%s\n", substr($3,9,2), substr($3,6,2), substr($3,1,4),$4,$5) }' >> covid19$theCountry.csv

 done

libreoffice --calc -o covid19$theCountry.csv

 

