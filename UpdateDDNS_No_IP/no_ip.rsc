##############Script Settings##################
:local noipuser "<No-IP UserName>"
:local noippass "<No-IP Password"
:local WANInter "<Internet interface>"
:local NOIPDomain "<Your DNS name>"
###############################################
 
:local localIP [/ip address get [find interface=$WANInter] address];

:local NewIP ""

:for i from=( [:len $localIP] - 1) to=0 do={ 
  :if ( [:pick $localIP $i] = "/") do={ 
    :set NewIP [:pick $localIP 0 $i];
   } 
}

:local reqv "http://dynupdate.no-ip.com/nic/update\3Fhostname=$NOIPDomain&myip=$NewIP"

:if ([:resolve $NOIPDomain] != $NewIP) do={
    /tool fetch mode="http"  user=$noipuser password=$noippass url=$reqv
}

