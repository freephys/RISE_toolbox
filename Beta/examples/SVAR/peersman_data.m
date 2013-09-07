function db=peersman_data()

% source: http://www.cambridge.org/features/econmodelling/download/MATLAB.zip

rawdata=[
%cpi_emu%              %cpi_us%               %intrate_emu%           %intrate_us%       %oil_price%                  %output_emu%           %output_us%       %Time%               
0.207076292000000    0.267334649000000     9.143985005999999     8.520000000000000    0.162428797000000    0.487918380000000    0.419149354000000		      %1970Q1%    
0.209769981000000    0.270279517000000     9.168653236999999     7.890000000000000    0.162428797000000    0.498571924000000    0.420019020000000		      %1970Q2%    
0.212229409000000    0.272933199000000     8.884121253000000     7.680000000000000    0.162428797000000    0.504177735000000    0.423697533000000		      %1970Q3%    
0.214468951000000    0.276586622000000     8.413420395999999     6.170000000000000    0.162428797000000    0.511022447000000    0.419149354000000		      %1970Q4%    
0.218202510000000    0.279210214000000     7.217834871000000     4.440000000000000    0.185150889000000    0.508898673000000    0.430854756000000		      %1971Q1%    
0.221276757000000    0.282370561000000     6.728124585000000     4.940000000000000    0.226483327000000    0.516228307000000    0.433216977000000		      %1971Q2%    
0.224117944000000    0.285168865000000     7.079955592000000     5.710000000000000    0.229175482000000    0.522371217000000    0.436542906000000		      %1971Q3%    
0.226984281000000    0.286971311000000     6.693976599000000     4.930000000000000    0.227844848000000    0.526773388000000    0.437635879000000		      %1971Q4%    
0.231124626000000    0.290029742000000     5.741619607000000     3.880000000000000    0.243226831000000    0.533906333000000    0.446226872000000		      %1972Q1%    
0.234015619000000    0.291820541000000     5.515290946000000     4.550000000000000    0.245223400000000    0.538687348000000    0.456439720000000		      %1972Q2%    
0.237589961000000    0.294375219000000     5.448879697000000     4.930000000000000    0.244558701000000    0.546109649000000    0.460964394000000		      %1972Q3%    
0.242027905000000    0.296807599000000     7.047031036000000     5.300000000000000    0.244558701000000    0.555329332000000    0.468979531000000		      %1972Q4%    
0.246255632000000    0.300493052000000     7.618434871000000     6.400000000000000    0.255916658000000    0.564299697000000    0.480943474000000		      %1973Q1%    
0.251574532000000    0.306330375000000     9.008766644000000     7.670000000000000    0.275958949000000    0.571988730000000    0.485761935000000		      %1973Q2%    
0.255889653000000    0.311865835000000    10.742318559999999    10.350000000000000    0.302675415000000    0.578966918000000    0.483846317000000		      %1973Q3%    
0.263043439000000    0.318220500000000    11.122510330000001     9.240000000000000    0.305331741000000    0.586191364000000    0.487853897000000		      %1973Q4%    
0.270325679000000    0.327663685000000    11.106368470000000     8.640000000000001    1.146451920000000    0.590424324000000    0.484116599000000		      %1974Q1%    
0.278354680000000    0.336764241000000    11.771586090000000    10.940000000000000    0.948522249000000    0.592776306000000    0.485421127000000		      %1974Q2%    
0.284708351000000    0.345576522000000    12.900222080000001    12.029999999999999    0.865091362000000    0.594432930000000    0.480026787000000		      %1974Q3%    
0.293241219000000    0.354216032000000    12.175288390000000     9.369999999999999    0.885840360000000    0.586903906000000    0.477382497000000		      %1974Q4%    
0.298913162000000    0.360722114000000     9.897378077999999     6.690000000000000    0.882553928000000    0.582297326000000    0.471271249000000		      %1975Q1%    
0.305103670000000    0.365036531000000     7.950793632000000     5.960000000000000    0.878559555000000    0.582637302000000    0.475408094000000		      %1975Q2%    
0.310623412000000    0.371680441000000     7.452885375000000     6.820000000000000    0.883226040000000    0.586956463000000    0.483658267000000		      %1975Q3%    
0.316720955000000    0.377772067000000     7.228745846000000     6.280000000000000    0.888563403000000    0.595405431000000    0.489746045000000		      %1975Q4%    
0.322932215000000    0.381796268000000     7.493433865000000     5.220000000000000    0.982812333000000    0.604652036000000    0.501369158000000		      %1976Q1%    
0.329715680000000    0.385096384000000     9.384298973000000     5.510000000000000    0.984808902000000    0.612949242000000    0.505529495000000		      %1976Q2%    
0.335466095000000    0.391174422000000     9.994405522999999     5.410000000000000    0.996155740000000    0.618313925000000    0.507926973000000		      %1976Q3%    
0.341677686000000    0.397643620000000    10.196452539999999     4.930000000000000    1.024893484000000    0.627955268000000    0.512099075000000		      %1976Q4%    
0.347770809000000    0.404581629000000     9.563816320000001     4.830000000000000    1.084359365000000    0.630345383000000    0.518339612000000		      %1977Q1%    
0.353991776000000    0.411807913000000     8.923893619999999     5.190000000000000    1.082344264000000    0.632337815000000    0.527659242000000		      %1977Q2%    
0.360085109000000    0.418108223000000     8.779492319999999     5.850000000000000    1.083075680000000    0.631954249000000    0.537155216000000		      %1977Q3%    
0.364630563000000    0.424057168000000     8.920562520000001     6.690000000000000    1.076436100000000    0.640559815000000    0.537801598000000		      %1977Q4%    
0.370097118000000    0.431211626000000     7.893354160000000     6.900000000000000    1.073768654000000    0.645142236000000    0.539305882000000		      %1978Q1%    
0.375824598000000    0.440458745000000     8.049196127000000     7.420000000000000    1.071789382000000    0.650115881000000    0.560084161000000		      %1978Q2%    
0.382035742000000    0.448423673000000     9.413170060000001     8.270000000000000    1.078475911000000    0.654662916000000    0.565490265000000		      %1978Q3%    
0.387489085000000    0.456723465000000     9.304868060000000    10.289999999999999    1.154632170000000    0.663221519000000    0.573047035000000		      %1978Q4%    
0.395747047000000    0.466194799000000     8.260030960000000    10.279999999999999    1.616556203000000    0.665756481000000    0.574492556000000		      %1979Q1%    
0.402834717000000    0.477614171000000     9.297108059999999    10.060000000000000    2.434635530000000    0.676896878000000    0.574856893000000		      %1979Q2%    
0.412297122000000    0.489282994000000    10.621308790000000    10.900000000000000    2.766101816000000    0.680905774000000    0.578946763000000		      %1979Q3%    
0.422738886000000    0.501454599000000    11.957284260000000    13.660000000000000    3.164126992000000    0.687077795000000    0.580874145000000		      %1979Q4%    
0.435793541000000    0.516877789000000    12.812380320000001    15.090000000000000    3.042383231000000    0.692985677000000    0.582789763000000		      %1980Q1%    
0.446104062000000    0.529909366000000    13.348709619999999    11.470000000000001    2.971432137000000    0.689827771000000    0.570908074000000		      %1980Q2%    
0.455236366000000    0.542214917000000    12.482015320000000     9.949999999999999    2.716733682000000    0.687971309000000    0.570026644000000		      %1980Q3%    
0.466453231000000    0.554503967000000    12.722916320000000    15.760000000000000    3.155640338000000    0.689116328000000    0.580169001000000		      %1980Q4%    
0.478042728000000    0.568335336000000    13.318167839999999    15.920000000000000    3.098063538000000    0.690474427000000    0.591439541000000		      %1981Q1%    
0.490665294000000    0.577994000000000    15.298377240000001    16.750000000000000    2.777710580000000    0.692891692000000    0.587302673000000		      %1981Q2%    
0.502452941000000    0.588404896000000    15.633862540000001    17.520000000000000    2.724513630000000    0.693301161000000    0.594295351000000		      %1981Q3%    
0.515316623000000    0.597843228000000    14.789595840000000    13.449999999999999    2.838276057000000    0.694859833000000    0.587279203000000		      %1981Q4%    
0.525911448000000    0.605236459000000    14.205160080000001    14.240000000000000    2.549711294000000    0.697538347000000    0.577548181000000		      %1982Q1%    
0.537799061000000    0.611240730000000    14.368487379999999    14.230000000000000    2.683324510000000    0.697904019000000    0.580039713000000		      %1982Q2%    
0.548081380000000    0.620592677000000    13.608056180000000    11.570000000000000    2.643270815000000    0.695481161000000    0.577289663000000		      %1982Q3%    
0.557817432000000    0.627249205000000    12.586611580000000     9.039999999999999    2.630538981000000    0.696274367000000    0.577700997000000		      %1982Q4%    
0.568596699000000    0.632156672000000    12.143712000000001     8.529999999999999    2.356607488000000    0.700770533000000    0.584376337000000		      %1983Q1%    
0.577522390000000    0.639516902000000    12.179479100000000     8.770000000000000    2.349729456000000    0.704109073000000    0.598173643000000		      %1983Q2%    
0.588180544000000    0.646041426000000    12.472954800000000     9.550000000000001    2.389706550000000    0.706205441000000    0.608821329000000		      %1983Q3%    
0.598708706000000    0.651584650000000    12.434144099999999     9.410000000000000    2.296242163000000    0.714527368000000    0.621325871000000		      %1983Q4%    
0.609353597000000    0.658099468000000    12.169570230000000     9.680000000000000    2.316849078000000    0.720291962000000    0.634899894000000		      %1984Q1%    
0.616870777000000    0.663810610000000    11.755963100000001    10.949999999999999    2.320272650000000    0.716775261000000    0.645653340000000		      %1984Q2%    
0.623814875000000    0.668716136000000    11.329572000000001    11.440000000000000    2.232134506000000    0.725148428000000    0.651235730000000		      %1984Q3%    
0.632031124000000    0.673500334000000    11.136445800000001     9.390000000000001    2.200757733000000    0.727692349000000    0.656148268000000		      %1984Q4%    
0.643741606000000    0.680247130000000    10.907338169999999     8.619999999999999    2.217465408000000    0.729425565000000    0.661624899000000		      %1985Q1%    
0.648974598000000    0.686616354000000    10.613826140000000     7.950000000000000    2.135115584000000    0.736261732000000    0.666807660000000		      %1985Q2%    
0.653562493000000    0.691293784000000     9.951098340000000     7.790000000000000    2.156518162000000    0.743319567000000    0.676773731000000		      %1985Q3%    
0.660345367000000    0.697890134000000     9.389792140000001     7.830000000000000    2.217939840000000    0.747868426000000    0.682344357000000		      %1985Q4%    
0.665947527000000    0.701682356000000     9.722481260000000     7.580000000000000    1.392819394000000    0.748064430000000    0.688561365000000		      %1986Q1%    
0.667545857000000    0.701971601000000     8.824321860000000     6.660000000000000    0.940527324000000    0.755924409000000    0.691428939000000		      %1986Q2%    
0.669560645000000    0.707158607000000     8.384307560000000                     6    0.944694668000000    0.760791485000000    0.697845761000000		      %1986Q3%    
0.676175267000000    0.712352408000000     8.421555659999999     5.830000000000000    1.150085528000000    0.764005152000000    0.701559531000000		      %1986Q4%    
0.681549970000000    0.721765504000000     8.634778500000000     6.050000000000000    1.404195884000000    0.760342725000000    0.706707059000000		      %1987Q1%    
0.686596432000000    0.729239297000000     8.711174400000001     6.820000000000000    1.440868013000000    0.773539509000000    0.714216890000000		      %1987Q2%    
0.689660488000000    0.736217101000000     8.684029799999999     6.940000000000000    1.466913602000000    0.779924093000000    0.720198850000000		      %1987Q3%    
0.695369515000000    0.743483180000000     8.467908899999999     7.640000000000000    1.392724260000000    0.790187455000000    0.732691628000000		      %1987Q4%    
0.699510841000000    0.748352793000000     7.662207000000000     6.720000000000000    1.231638453000000    0.795151483000000    0.737568874000000		      %1988Q1%    
0.706446165000000    0.756902035000000     7.491401700000000     7.220000000000000    1.248970056000000    0.801827731000000    0.746253886000000		      %1988Q2%    
0.712296377000000    0.766030739000000     8.104402049999999     8.170000000000000    1.089738735000000    0.810732592000000    0.750073416000000		      %1988Q3%    
0.720014409000000    0.773587035000000     8.545479710000000     8.800000000000001    0.993367215000000    0.818874364000000    0.759816203000000		      %1988Q4%    
0.728153191000000    0.782316813000000     9.554233220000000     9.600000000000000    1.310992187000000    0.829514524000000    0.769053542000000		      %1989Q1%    
0.738075599000000    0.792707326000000     9.869469893000000     9.580000000000000    1.401259099000000    0.833613673000000    0.773237408000000		      %1989Q2%    
0.744928692000000    0.797650706000000    10.157935330000001     8.730000000000000    1.325071952000000    0.840091902000000    0.776904181000000		      %1989Q3%    
0.752099515000000    0.805331241000000    10.939394170000000     8.440000000000000    1.439957449000000    0.849260467000000    0.779595469000000		      %1989Q4%    
0.758197526000000    0.816052736000000    11.232711650000001     8.240000000000000    1.471351520000000    0.860108308000000    0.789326433000000		      %1990Q1%    
0.766365508000000    0.824860164000000    10.680380220000000     8.330000000000000    1.193977923000000    0.865335339000000    0.791136349000000		      %1990Q2%    
0.776690758000000    0.835898082000000    10.599855880000000     8.039999999999999    2.033881134000000    0.872350636000000    0.789690769000000		      %1990Q3%    
0.786211091000000    0.847751323000000    11.042066490000000     7.970000000000000    2.456921491000000    0.878575664000000    0.783203479000000		      %1990Q4%    
0.794452980000000    0.854060368000000    11.161894739999999     6.710000000000000    1.516035872000000    0.884370258000000    0.779348656000000		      %1991Q1%    
0.804163898000000    0.859595828000000    10.534663159999999     6.010000000000000    1.377019812000000    0.886480334000000    0.783708809000000		      %1991Q2%    
0.817048068000000    0.865406944000000    10.587923060000000     5.700000000000000    1.470674466000000    0.887576470000000    0.785636191000000		      %1991Q3%    
0.828816945000000    0.872753585000000    10.786210540000001     4.910000000000000    1.522836067000000    0.894367281000000    0.789867055000000		      %1991Q4%    
0.835863981000000    0.880561272000000    10.903283030000001     4.120000000000000    1.352377752000000    0.905418040000000    0.797200541000000		      %1992Q1%    
0.843977188000000    0.886624750000000    11.041116600000001     3.890000000000000    1.524316197000000    0.899835629000000    0.804663315000000		      %1992Q2%    
0.851169928000000    0.891546777000000    12.019344660000000     3.270000000000000    1.543788922000000    0.898010796000000    0.810880382000000		      %1992Q3%    
0.858575874000000    0.898312985000000    11.619721730000000     3.440000000000000    1.464868849000000    0.895551901000000    0.821563302000000		      %1992Q4%    
0.870063385000000    0.903290337000000    10.852356570000000     3.140000000000000    1.375213510000000    0.889084327000000    0.821340018000000		      %1993Q1%    
0.878582792000000    0.908908300000000     9.192547869000000     3.130000000000000    1.377210079000000    0.889492940000000    0.826334788000000		      %1993Q2%    
0.886294124000000    0.911960907000000     8.317190707000000     3.140000000000000    1.240137462000000    0.893331679000000    0.829954504000000		      %1993Q3%    
0.893596501000000    0.917565281000000     7.654898415000000     3.280000000000000    1.144592492000000    0.896861640000000    0.842494338000000		      %1993Q4%    
0.901555893000000    0.920202462000000     7.076676328000000     3.450000000000000    1.079159143000000    0.904602689000000    0.849628010000000		      %1994Q1%    
0.908228710000000    0.925056545000000     6.574818133000000     4.350000000000000    1.250367407000000    0.909300331000000    0.861474464000000		      %1994Q2%    
0.915451994000000    0.933030208000000     6.625162550000000     4.860000000000000    1.315937896000000    0.915525954000000    0.866175425000000		      %1994Q3%    
0.921999670000000    0.937132058000000     6.749742428000000     5.860000000000000    1.296538065000000    0.923315958000000    0.876858345000000		      %1994Q4%    
0.929287671000000    0.942926674000000     7.183240670000000     6.180000000000000    1.342756908000000    0.929609210000000    0.880102019000000		      %1995Q1%    
0.937399918000000    0.948388366000000     7.345685350000000     6.010000000000000    1.417551645000000    0.935203724000000    0.881817822000000		      %1995Q2%    
0.944075179000000    0.952729960000000     6.894718937000000     5.760000000000000    1.268447723000000    0.937016285000000    0.888645979000000		      %1995Q3%    
0.950436539000000    0.956683306000000     6.577808083000000     5.720000000000000    1.320562375000000    0.939145179000000    0.895756181000000		      %1995Q4%    
0.957282850000000    0.962406095000000     5.841928058000000     5.280000000000000    1.416034451000000    0.941621618000000    0.902161239000000		      %1996Q1%    
0.964246712000000    0.968488015000000     5.357768125000000     5.390000000000000    1.478872013000000    0.947576648000000    0.917028025000000		      %1996Q2%    
0.967041183000000    0.972358858000000     5.206173345000000     5.480000000000000    1.589995410000000    0.952493840000000    0.921611461000000		      %1996Q3%    
0.972951084000000    0.979060035000000     4.772584030000000     5.410000000000000    1.795943481000000    0.954783045000000    0.932118095000000		      %1996Q4%    
0.977907370000000    0.984989567000000     4.602843095000000     5.440000000000000    1.630072579000000    0.958465806000000    0.942119400000000		      %1997Q1%    
0.981487871000000    0.987793695000000     4.478363180000000     5.690000000000000    1.433700874000000    0.969430159000000    0.955693422000000		      %1997Q2%    
0.988248500000000    0.990844361000000     4.453749715000000     5.600000000000000    1.459055818000000    0.975752578000000    0.965647670000000		      %1997Q3%    
0.992948781000000    0.994151272000000     4.600156053000000     5.730000000000000    1.476452902000000    0.985840486000000    0.972264365000000		      %1997Q4%    
0.995841666000000    0.995617882000000     4.383393895000000     5.550000000000000    1.067699875000000    0.993620586000000    0.986766756000000		      %1998Q1%    
0.999469649000000    0.998025026000000     4.228312225000000     5.590000000000000    1.015585223000000    0.997623297000000    0.992243445000000		      %1998Q2%    
1.002310708000000    1.001437734000000     4.130353375000000     5.530000000000000    1.002450615000000    1.003020306000000    1.002303453000000		      %1998Q3%    
1.002377977000000    1.004919357000000     3.767815530000000     5.200000000000000    0.914264287000000    1.005735811000000    1.018686346000000		      %1998Q4%    
1.004715535000000    1.007978759000000     3.236701100000000     4.900000000000000    0.888070438000000    1.014188915000000    1.026360640000000		      %1999Q1%    
1.010635302000000    1.013617105000000     2.785500600000000     4.980000000000000    1.231140546000000    1.019935394000000    1.031331881000000		      %1999Q2%    
1.013773394000000    1.019039001000000     2.846461000000000     5.380000000000000    1.604843657000000    1.032061707000000    1.044424102000000		      %1999Q3%    
1.018032863000000    1.025101509000000     3.558933700000000     6.060000000000000    1.883619547000000    1.044331616000000    1.062428685000000		      %1999Q4%    
1.024629270000000    1.033779844000000     3.623074600000000     6.030000000000000    2.056621758000000    1.053690597000000    1.069162905000000		      %2000Q1%    
1.029704348000000    1.039603578000000     4.311381400000000     6.570000000000000    2.074840451000000    1.062599386000000    1.081890731000000		      %2000Q2%    
1.036987246000000    1.044976944000000     4.775054600000000     6.630000000000000    2.333436909000000    1.067830194000000    1.083418543000000		      %2000Q3%    
1.043548477000000    1.050757001000000     5.026722800000000     6.590000000000000    2.299451994000000    1.075627810000000    1.086368348000000		      %2000Q4%    
1.049615633000000    1.059414952000000     4.750000000000000     5.260000000000000    1.991806160000000    1.081713218000000    1.084734835000000		      %2001Q1%    
1.058031397000000    1.064168090000000     4.590000000000000     4.100000000000000    2.107505852000000    1.082014287000000    1.080409858000000		      %2001Q2%    
1.062309157000000    1.063983672000000     4.270000000000000     3.350000000000000    1.980590285000000    1.083729130000000    1.079622541000000		      %2001Q3%    
1.065435887000000    1.066108365000000     3.440000000000000     2.060000000000000    1.514516206000000    1.081219613000000    1.086955968000000		      %2001Q4%    
1.074634813000000    1.069028967000000     3.360000000000000     1.830000000000000    1.658959820000000    1.085082242000000    1.100400761000000		      %2002Q1%    
1.078994552000000    1.075697143000000     3.440000000000000     1.830000000000000    1.965867386000000    1.092317002000000    1.103503324000000		      %2002Q2%    
];

db=rise_time_series('1970Q1',rawdata,...
{'cpi_emu','cpi_us','intrate_emu','intrate_us','oil_price','output_emu','output_us'});

db=pages2struct(db);