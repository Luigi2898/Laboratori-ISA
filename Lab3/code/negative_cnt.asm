#################
# Basic VERSION	
# This program takes an array v and computes
# min{|v[i]|}, the minimum of the absolute value,
# where v[i] is the i-th element in the array
	.data
	.align	2
v:
.word    124883
.word    200057
.word    -131273
.word    -188906
.word    -140216
.word    -76493
.word    -108587
.word    218019
.word    -228830
.word    47260
.word    -171922
.word    172587
.word    -169544
.word    1122
.word    254659
.word    -73742
.word    -230991
.word    -146033
.word    -52102
.word    -84829
.word    -137903
.word    222422
.word    93426
.word    235678
.word    -31634
.word    224572
.word    -252025
.word    56257
.word    153549
.word    -136180
.word    220559
.word    134264
.word    166490
.word    37467
.word    149217
.word    -87189
.word    -141035
.word    -95683
.word    43107
.word    168257
.word    -106864
.word    -49697
.word    184650
.word    58517
.word    250506
.word    -151114
.word    166877
.word    89690
.word    -128036
.word    -12349
.word    -51472
.word    50714
.word    153267
.word    -201415
.word    163936
.word    173954
.word    -74202
.word    -35665
.word    36842
.word    102421
.word    123660
.word    131521
.word    -56544
.word    -36056
.word    232736
.word    37215
.word    178359
.word    -114064
.word    62385
.word    45065
.word    236369
.word    -211190
.word    254
.word    11011
.word    -209016
.word    206380
.word    196039
.word    -31115
.word    143679
.word    -179283
.word    61106
.word    -122082
.word    -27715
.word    175440
.word    -154936
.word    -100036
.word    -8520
.word    -82716
.word    152228
.word    248619
.word    -173886
.word    -134192
.word    103141
.word    -63510
.word    241590
.word    240876
.word    73286
.word    183651
.word    -50040
.word    67285
.word    247471
.word    30334
.word    221132
.word    112375
.word    -8140
.word    70906
.word    197695
.word    -153645
.word    -53363
.word    251010
.word    -49801
.word    81017
.word    204688
.word    252645
.word    78113
.word    -199698
.word    -236582
.word    60227
.word    34244
.word    235602
.word    125514
.word    82883
.word    11890
.word    -122454
.word    235617
.word    20504
.word    -239563
.word    100121
.word    10055
.word    -224895
.word    198919
.word    -86597
.word    -137853
.word    -196887
.word    -96430
.word    -138500
.word    77519
.word    -221259
.word    -114530
.word    -111272
.word    193834
.word    -28392
.word    130516
.word    52681
.word    144466
.word    -196896
.word    244068
.word    177785
.word    -229171
.word    -17237
.word    -88917
.word    66405
.word    -137548
.word    40741
.word    52610
.word    50938
.word    -26302
.word    -236934
.word    7046
.word    -47058
.word    -199897
.word    -20463
.word    -25050
.word    26082
.word    155757
.word    102434
.word    189840
.word    -228382
.word    -142963
.word    -20583
.word    233853
.word    147923
.word    -24544
.word    -84952
.word    -224862
.word    122862
.word    3465
.word    -153038
.word    -37131
.word    -168968
.word    128364
.word    -67141
.word    225328
.word    -246242
.word    167819
.word    64562
.word    19761
.word    76759
.word    115581
.word    -206811
.word    192563
.word    -247676
.word    -104906
.word    -163244
.word    217411
.word    -220228
.word    41358
.word    69947
.word    77147
.word    185958
.word    -226465
.word    161596
.word    14750
.word    99119
.word    -146674
.word    22073
.word    103286
.word    232782
.word    -28284
.word    -211448
.word    -225757
.word    66020
.word    151052
.word    97508
.word    -78893
.word    227877
.word    10297
.word    231445
.word    -217467
.word    -149414
.word    140264
.word    211236
.word    144101
.word    -104278
.word    -177559
.word    177435
.word    145276
.word    -116876
.word    -138817
.word    -91278
.word    168077
.word    164313
.word    36048
.word    36633
.word    -109131
.word    101558
.word    151092
.word    -29790
.word    -27430
.word    -17512
.word    -112690
.word    89442
.word    205869
.word    208349
.word    126071
.word    -122139
.word    96715
.word    -187767
.word    -192015
.word    -157640
.word    -180677
.word    43372
.word    -217586
.word    164387
.word    113681
.word    217188
.word    -3754
.word    78990
.word    198963
.word    19648
.word    -111076
.word    242739
.word    -236423
.word    -88615
.word    241237
.word    -68833
.word    -97334
.word    -193335
.word    212041
.word    -185906
.word    -85620
.word    202715
.word    -179
.word    58797
.word    42398
.word    101110
.word    -240041
.word    14220
.word    -238643
.word    166843
.word    -81607
.word    176823
.word    -129505
.word    41561
.word    223216
.word    -230629
.word    -227472
.word    -244485
.word    92554
.word    50301
.word    -196845
.word    151085
.word    60104
.word    -219192
.word    -219668
.word    -185637
.word    147335
.word    -207877
.word    -133687
.word    -130740
.word    -201541
.word    182760
.word    101082
.word    119209
.word    76771
.word    8298
.word    -88542
.word    82506
.word    -195042
.word    -179613
.word    -244921
.word    236789
.word    239891
.word    -191832
.word    -16621
.word    79914
.word    -107006
.word    129814
.word    29640
.word    -36826
.word    -118731
.word    129406
.word    203172
.word    116507
.word    -47517
.word    223542
.word    -124732
.word    16913
.word    231925
.word    -118449
.word    -127457
.word    218114
.word    -220023
.word    -102306
.word    46708
.word    -151318
.word    69301
.word    152169
.word    868
.word    76914
.word    150937
.word    -135980
.word    51428
.word    -197645
.word    8040
.word    172299
.word    214603
.word    -904
.word    -113419
.word    77785
.word    212823
.word    5018
.word    241838
.word    -154388
.word    -198296
.word    -103350
.word    -52827
.word    -40415
.word    -96148
.word    98860
.word    -208146
.word    -49935
.word    -104458
.word    -98687
.word    -201164
.word    47852
.word    -110809
.word    -175837
.word    -254665
.word    -110367
.word    25914
.word    189160
.word    -233451
.word    206409
.word    -188204
.word    170202
.word    153239
.word    213119
.word    -184975
.word    2413
.word    -48471
.word    -166479
.word    38344
.word    54171
.word    -145633
.word    10165
.word    249485
.word    -5143
.word    99386
.word    -45175
.word    -237264
.word    -105656
.word    153736
.word    -78284
.word    -212509
.word    5664
.word    -67915
.word    122135
.word    12618
.word    155306
.word    161625
.word    -158370
.word    -191917
.word    163709
.word    70328
.word    -246779
.word    201937
.word    7841
.word    22706
.word    54286
.word    132823
.word    181227
.word    -59737
.word    -211829
.word    119276
.word    -85686
.word    173273
.word    -65421
.word    167390
.word    -164976
.word    -188945
.word    193741
.word    -232520
.word    95227
.word    119224
.word    -32042
.word    -61282
.word    244626
.word    -51513
.word    -30505
.word    -175028
.word    -88723
.word    -94829
.word    201196
.word    -129018
.word    -96554
.word    -46477
.word    106086
.word    -181745
.word    189375
.word    -212591
.word    -19514
.word    -239502
.word    129133
.word    102022
.word    -145599
.word    91752
.word    29219
.word    178847
.word    29868
.word    204905
.word    -41046
.word    -72355
.word    -5616
.word    -124460
.word    218877
.word    -16954
.word    -125456
.word    -35079
.word    103291
.word    -49812
.word    -162262
.word    181688
.word    42943
.word    -64475
.word    -141936
.word    -143313
.word    11339
.word    -33954
.word    123065
.word    -219071
.word    177140
.word    91739
.word    -185308
.word    182785
.word    -153085
.word    54743
.word    21953
.word    -172215
.word    -252117
.word    138458
.word    135042
.word    -40255
.word    -226026
.word    43731
.word    -166181
.word    116592
.word    17488
.word    -125937
.word    212699
.word    131679
.word    197386
.word    -219913
.word    -161401
.word    120907
.word    100325
.word    141267
.word    971
.word    -37997
.word    56731
.word    181444
.word    87107
.word    12032
.word    -102604
.word    104024
.word    -60379
.word    34519
.word    197809
.word    174904
.word    203388
.word    223892
.word    160872
.word    -254308
.word    -253424
.word    -210391
.word    -122029
.word    -243373
.word    -38717
.word    -81057
.word    21091
.word    217347
.word    -102765
.word    -82577
.word    183335
.word    -81356
.word    -184559
.word    3977
.word    181895
.word    -59000
.word    99803
.word    65231
.word    -25302
.word    -13455
.word    229351
.word    -212417
.word    -112287
.word    -27026
.word    44661
.word    192594
.word    -15759
.word    -31917
.word    125555
.word    -16366
.word    184022
.word    -17079
.word    -967
.word    -6410
.word    -137971
.word    -211369
.word    -220635
.word    198080
.word    -136085
.word    184414
.word    107985
.word    190135
.word    223381
.word    -183759
.word    -54111
.word    245088
.word    73845
.word    202169
.word    -9063
.word    -247813
.word    62669
.word    -137142
.word    13991
.word    114746
.word    54782
.word    45067
.word    -33948
.word    -130472
.word    -36230
.word    -249810
.word    55499
.word    233568
.word    -206323
.word    -236849
.word    196980
.word    -129060
.word    -250454
.word    160610
.word    -183346
.word    193732
.word    -206358
.word    -75194
.word    47645
.word    43443
.word    85518
.word    75494
.word    -33982
.word    -183723
.word    128484
.word    -131689
.word    76734
.word    182261
.word    -211971
.word    240766
.word    -238956
.word    171057
.word    171214
.word    -229573
.word    23402
.word    226017
.word    -91049
.word    156298
.word    51713
.word    147707
.word    152585
.word    -229722
.word    -110569
.word    78263
.word    -5276
.word    241155
.word    126730
.word    34599
.word    -102528
.word    -124384
.word    197148
.word    -27132
.word    161154
.word    -204848
.word    183393
.word    -240910
.word    203570
.word    203968
.word    12294
.word    -193699
.word    -164325
.word    105115
.word    168994
.word    -237235
.word    131498
.word    233128
.word    -80136
.word    70504
.word    -80067
.word    -144600
.word    145963
.word    113776
.word    -112792
.word    42040
.word    -40287
.word    -208045
.word    -242747
.word    -4516
.word    -113084
.word    -81724
.word    -108452
.word    -167840
.word    -51376
.word    100801
.word    -151125
.word    84827
.word    -29036
.word    -34019
.word    -165628
.word    -156467
.word    59375
.word    -117805
.word    30436
.word    226840
.word    109381
.word    91402
.word    234285
.word    140421
.word    54941
.word    228482
.word    -224583
.word    -117957
.word    248207
.word    138826
.word    -12569
.word    92259
.word    -42363
.word    -61124
.word    -146232
.word    -59702
.word    -239870
.word    -14116
.word    -84980
.word    242681
.word    28276
.word    176615
.word    -46888
.word    -19371
.word    166417
.word    250514
.word    12213
.word    216973
.word    121901
.word    34389
.word    239077
.word    165495
.word    234401
.word    74637
.word    -61418
.word    -11947
.word    210064
.word    -247425
.word    -175086
.word    -14500
.word    21926
.word    -224558
.word    80596
.word    198714
.word    -199088
.word    -31736
.word    -112083
.word    247476
.word    55467
.word    -125588
.word    -187367
.word    22953
.word    167180
.word    171874
.word    170008
.word    -151105
.word    22653
.word    191221
.word    -193290
.word    181739
.word    203886
.word    -143889
.word    -215741
.word    -13150
.word    170864
.word    -15609
.word    -43977
.word    1401
.word    -191026
.word    -187535
.word    188943
.word    52505
.word    -119696
.word    186050
.word    -225365
.word    -21546
.word    113327
.word    -82111
.word    -50378
.word    13760
.word    201061
.word    141964
.word    -219623
.word    -112820
.word    -61522
.word    185983
.word    -40820
.word    -132663
.word    49804
.word    -10504
.word    203260
.word    221702
.word    162123
.word    106544
.word    124043
.word    203852
.word    -221728
.word    -83685
.word    -252790
.word    167329
.word    3792
.word    -68257
.word    -139414
.word    17764
.word    -107363
.word    -220131
.word    -211665
.word    -220147
.word    -45994
.word    -192076
.word    -29062
.word    203460
.word    -74644
.word    -193710
.word    35247
.word    191267
.word    -77227
.word    -233621
.word    -182407
.word    -215938
.word    122669
.word    -22172
.word    85807
.word    101616
.word    36392
.word    65634
.word    192660
.word    82800
.word    191461
.word    -16566
.word    -182919
.word    -220252
.word    109264
.word    -97927
.word    87294
.word    77735
.word    15835
.word    109705
.word    2453
.word    -6120
.word    -1102
.word    222348
.word    -56466
.word    -195256
.word    -132384
.word    94304
.word    173020
.word    239774
.word    -145264
.word    132775
.word    42893
.word    -49495
.word    5121
.word    -2221
.word    77198
.word    124290
.word    -101004
.word    -209298
.word    166243
.word    -56311
.word    140406
.word    -163522
.word    -199226
.word    206631
.word    191939
.word    254895
.word    185770
.word    -236193
.word    22788
.word    253785
.word    5614
.word    190492
.word    -219187
.word    248645
.word    215584
.word    32773
.word    -34954
.word    -82699
.word    112569
.word    -248036
.word    -64229
.word    215570
.word    23705
.word    -13318
.word    -1766
.word    -97425
.word    229928
.word    245817
.word    6917
.word    251221
.word    -22520
.word    -37719
.word    -146261
.word    -156443
.word    169705
.word    115585
.word    15170
.word    167832
.word    6056
.word    26501
.word    -146225
.word    44789
.word    -182191
.word    -228366
.word    93487
.word    55365
.word    -142976
.word    -47797
.word    66253
.word    28207
.word    -189935
.word    -168709
.word    -254491
.word    -41737
.word    -5872
.word    -173467
.word    85088
.word    -245861
.word    -193966
.word    230584
.word    242686
.word    -239234
.word    -3120
.word    184989
.word    -131133
.word    170478
.word    159932
.word    65776
.word    -253859
.word    -61341
.word    206247
.word    91980
.word    -61800
.word    67297
.word    -130933
.word    36421
.word    245682
.word    178338
.word    -110444
.word    93054
.word    -72357
.word    248333
.word    -212167
.word    -127344
.word    158787
.word    -211945
.word    15940
.word    153318
.word    121800
.word    -182752
.word    -31674
.word    -76306
.word    -10966
.word    44576
.word    -180639
.word    206719
.word    71499
.word    -171901
.word    33614
.word    220125
.word    144382
.word    94701
.word    -17228
.word    -122238
.word    35327
.word    -128127
.word    -92156
.word    209510
.word    196463
.word    150241
.word    217163
.word    -163792
.word    8946
.word    64773
.word    210723
.word    83624
.word    -56512
.word    122404
.word    161994
.word    51176
.word    -211652
.word    215403
.word    -227666
.word    13783
.word    -194385
.word    -61127
.word    159545
.word    -130511
.word    196056
.word    108450
.word    -62144
.word    -128051
.word    -126045
.word    136295
.word    -229571
.word    94497
.word    61342
.word    125809
.word    243401
.word    -59204
.word    -122295
.word    192510
.word    156109
.word    -19828
.word    -208610
.word    32777
.word    -159435
.word    16162
.word    -73933
.word    -94461
.word    115638
.word    8044
.word    148229
.word    -150709
.word    90834
.word    -228233
.word    153598
.word    91070
.word    227465
.word    -208306
.word    208304
.word    5076
.word    58601
.word    -93804
.word    -215482
.word    178814
.word    -181292
.word    -66052
.word    62420
.word    253752
.word    8846
.word    250161
.word    -139468
.word    -52017
.word    100250
.word    -222034
.word    126308
.word    -40596
.word    158772
.word    -61401
.word    -92276
.word    247887
.word    111272
.word    -44277
.word    -204699
.word    119625
.word    70026
.word    -217341
.word    -193541
.word    245615
.word    -1632
.word    -243570
.word    -227546
.word    -183155
.word    200672
.word    -17432
.word    31037
.word    -2827
.word    -220430
.word    202800
.word    -107832
.word    -117786
.word    48039
.word    -12302
.word    -67162
.word    79362
.word    223483
.word    61417
.word    -110752
.word    -150358
.word    -31042
.word    -241103
.word    191854
.word    56147
.word    -151168
.word    10158
.word    -227550
.word    184716
.word    -29103
.word    24485
.word    34099
.word    92002
.word    -65597
.word    -215104
.word    -22261
.word    -230600
.word    121511
.word    -235620
.word    231665
.word    123610
.word    223100
.word    6816
.word    -132139
.word    -122418
.word    132077
.word    251605
.word    -73080
.word    128958
.word    -198876
.word    49493
.word    -35397
.word    117666
.word    -121800
.word    -206648
.word    -25009
.word    71438
.word    -187661
.word    -24061
.word    77622
.word    166769
.word    -97881
.word    -49795
.word    195958
.word    102296
.word    -131645
.word    132514
.word    -106628
.word    -113506
.word    -251886
.word    -63897
.word    -32164
.word    -99808
.word    -106661
.word    -131317
.word    222709
.word    183697
.word    -52414
.word    -10496
.word    33148
.word    -5294
.word    -117396
.word    249768
.word    -161326
.word    184445
.word    -238358
.word    -85702
.word    126861
.word    73627
.word    -168689
.word    230625
.word    22068
.word    -126779
.word    40072
.word    211893
.word    201755
.word    -8922
.word    -29203
.word    -96005
.word    -226790
.word    129434
.word    -187707
.word    -73480
.word    -53106
.word    196616
.word    -244168
.word    175482
.word    -108084
.word    -127325
.word    -5926
.word    116809
.word    -151666
.word    -144699
.word    242931
.word    47550
.word    -99754
.word    238529
.word    201945
.word    -158087
.word    -254083
.word    108000
.word    187541
.word    -194663
.word    -235099
.word    50079
.word    53200
.word    8381
.word    -251172
.word    96356
.word    227471
.word    190504
.word    -197229
.word    -74170
.word    -131612
.word    30770
.word    57491
.word    -101588
.word    152053
.word    150778
.word    143357
.word    -75940
.word    -227309
.word    106440
.word    251394
.word    -172137
.word    -197082
.word    210567
.word    -9355
.word    179421
.word    158056
.word    -159753
.word    -128928
.word    -227364
.word    55570
.word    141389
.word    5643
.word    -240848
.word    250097
.word    479
.word    -85681
.word    -166320
.word    64075
.word    38319
.word    128003
.word    -176706
.word    -73039
.word    -181585
.word    178810
.word    -82687
.word    -114650
.word    -251935
.word    153975
.word    -1322
.word    19300
.word    189166
.word    113650
.word    85724
.word    -163798
.word    25753
.word    234537
.word    48971
.word    157371
.word    247112
.word    196822
.word    -145943
.word    -237339
.word    -24927
.word    -247965
.word    -13408
.word    230111
.word    -128035
.word    -57924
.word    -34969
.word    168752
.word    165570
.word    -23971
.word    -60914
.word    217193
.word    122830
.word    121193
.word    227928
.word    5151
.word    148859
.word    -24392
.word    178092
.word    -55880
.word    121572
.word    242984
.word    11883
.word    -35743
.word    -149350
.word    -90065
.word    -198457
.word    -63643
.word    -86749
.word    -80527
.word    161731
.word    16160
.word    10772
.word    139898
.word    -193666
.word    63980
.word    -78209
.word    -84344
.word    38055
.word    185609
.word    -153733
.word    87950
.word    204934
.word    -153430
.word    -102875
.word    -1775
.word    198852
.word    721
.word    -113733
.word    17319
.word    37867
.word    -44470
.word    -247471
.word    103410
.word    3441
.word    -60554
.word    -221885
.word    -72124
.word    -135532
.word    -151213
.word    160028
.word    -54348
.word    -227677
.word    -63724
.word    140247
.word    -170699
.word    210232
.word    -92205
.word    -86813
.word    -150840
.word    136280
.word    -219314
.word    229518
.word    -174313
.word    -108913
.word    95436
.word    -183014
.word    6164
.word    112877
.word    218711
.word    118373
.word    127423
.word    -47267
.word    -132859
.word    10634
.word    -143271
.word    174618
.word    83096
.word    161280
.word    149878
.word    -15756
.word    -97142
.word    95666
.word    248295
.word    137667
.word    168087
.word    105103
.word    48622
.word    128966
.word    -1672
.word    186218
.word    -220306
.word    238959
.word    -204635
.word    23958
.word    -49485
.word    -200410
.word    114325
.word    57978
.word    144314
.word    33977
.word    158773
.word    39156
.word    226455
.word    189441
.word    3877
.word    147300
.word    -13754
.word    167689
.word    -90535
.word    242835
.word    -113113
.word    -217857
.word    128124
.word    168907
.word    215393
.word    -88218
.word    155076
.word    19508
.word    -18720
.word    163583
.word    230473
.word    -216101
.word    106422
.word    -135188
.word    -51563
.word    -118257
.word    169582
.word    252641
.word    76373
.word    104016
.word    220475
.word    95703
.word    34861
.word    -60768
.word    68636
.word    -69754
.word    -47114
.word    -66963
.word    -16117
.word    1741
.word    209374
.word    -149720
.word    -82312
.word    37804
.word    -6664
.word    -121269
.word    40593
.word    192948
.word    -223916
.word    -30153
.word    -212029
.word    32251
.word    20048
.word    136710
.word    -136124
.word    44555
.word    -20923
.word    184101
.word    82027
.word    -74522
.word    -77935
.word    -125604
.word    230790
.word    -102918
.word    -174213
.word    -70739
.word    123231
.word    105009
.word    102455
.word    -251825
.word    -64084
.word    204763
.word    -92644
.word    49512
.word    -103125
.word    -191243
.word    -56939
.word    162021
.word    245400
.word    184615
.word    -212252
.word    -82767
.word    -134574
.word    -92919
.word    247069
.word    24608
.word    127118
.word    174345
.word    -169887
.word    205580
.word    -201387
.word    124998
.word    116980
.word    110910
.word    -186950
.word    -27648
.word    4481
.word    15550
.word    183456
.word    90640
.word    155978
.word    15934
.word    232507
.word    -220995
.word    21174
.word    -111353
.word    -9741
.word    94281
.word    -148789
.word    55162
.word    -88650
.word    194232
.word    -186969
.word    -202772
.word    234150
.word    -177020
.word    -177206
.word    -175669
.word    -209320
.word    -23244
.word    86137
.word    168964
.word    148020
.word    108483
.word    -13975
.word    106380
.word    233611
.word    2946
.word    -99423
.word    147804
.word    -134443
.word    -135506
.word    -18003
.word    60887
.word    58818
.word    -192462
.word    -191866
.word    -109926
.word    120224
.word    -45233
.word    167781
.word    221909
.word    -51476
.word    -228373
.word    36305
.word    126312
.word    -91676
.word    -3604
.word    -141957
.word    224030
.word    -9024
.word    20398
.word    -142261
.word    -206068
.word    -224316
.word    162950
.word    138454
.word    -155195
.word    201511
.word    93993
.word    79992
.word    250095
.word    -237818
.word    -38631
.word    -5108
.word    42587
.word    -212533
.word    81679
.word    -228325
.word    28984
.word    108133
.word    -6166
.word    59976
.word    -145974
.word    74286
.word    -60873
.word    -202107
.word    -62469
.word    -120941
.word    -131945
.word    62691
.word    11693
.word    -44249
.word    -143926
.word    182863
.word    184115
.word    -110191
.word    58850
.word    142540
.word    231973
.word    213998
.word    -58744
.word    -172052
.word    151344
.word    -196954
.word    -174000
.word    -73528
.word    177357
.word    42218
.word    43951
.word    217178
.word    38290
.word    -249912
.word    157783
.word    55492
.word    -10244
.word    -118096
.word    -123371
.word    -9685
.word    -139056
.word    -230213
.word    -168687
.word    -123193
.word    -154066
.word    53904
.word    165089
.word    158414
.word    154141
.word    106138
.word    183283
.word    143353
.word    -151064
.word    251606
.word    -207252
.word    76816
.word    -145260
.word    -130625
.word    -81759
.word    -154091
.word    3485
.word    229887
.word    -53750
.word    43077
.word    54334
.word    109468
.word    -50217
.word    182933
.word    214448
.word    127928
.word    -109348
.word    151376
.word    -182190
.word    2321
.word    56451
.word    103937
.word    -59497
.word    116629
.word    197516
.word    -226518
.word    -184510
.word    185164
.word    -39909
.word    -45230
.word    234163
.word    127625
.word    245309
.word    -135907
.word    -205925
.word    -58863
.word    139
.word    35831
.word    243083
.word    -3644
.word    -50550
.word    252446
.word    -121891
.word    84316
.word    236771
.word    87287
.word    -102421
.word    15875
.word    -254254
.word    195733
.word    -48764
.word    -101385
.word    229797
.word    -20069
.word    -108300
.word    -211841
.word    41913
.word    -176935
.word    -217722
.word    41088
.word    -108623
.word    -70421
.word    114661
.word    182739
.word    -77563
.word    235491
.word    231321
.word    -149921
.word    136805
.word    58921
.word    213651
.word    52294
.word    103091
.word    124274
.word    -58598
.word    -126733
.word    -236253
.word    -14217
.word    73987
.word    -112726
.word    9109
.word    -129710
.word    -103271
.word    76742
.word    199611
.word    184165
.word    -147944
.word    -51462
.word    197821
.word    -124171
.word    238069
.word    60770
.word    -170674
.word    166362
.word    79404
.word    23691
.word    -126822
.word    -234521
.word    -135979
.word    -70833
.word    68062
.word    247911
.word    -149350
.word    131113
.word    197028
.word    -14163
.word    -173954
.word    158570
.word    -11981
.word    -195694
.word    191618
.word    68945
.word    -205387
.word    208305
.word    -237142
.word    -234728
.word    249170
.word    94953
.word    -62889
.word    2205
.word    134383
.word    -230074
.word    115223
.word    102678
.word    -20966
.word    41970
.word    -82064
.word    -167981
.word    -51411
.word    214087
.word    -139717
.word    -70887
.word    -89474
.word    -212374
.word    6459
.word    169761
.word    206353
.word    114034
.word    -59672
.word    -103012
.word    97773
.word    194033
.word    216520
.word    -213562
.word    -8837
.word    -189585
.word    -126016
.word    195821
.word    -154899
.word    -193110
.word    22284
.word    -94544
.word    -60159
.word    148685
.word    172982
.word    91921
.word    -42370
.word    72874
.word    -145819
.word    59808
.word    89348
.word    51522
.word    -78382
.word    -69155
.word    -167545
.word    150635
.word    -3740
.word    -74142
.word    140281
.word    -134230
.word    175865
.word    161429
.word    176577
.word    -66205
.word    -59553
.word    184281
.word    -18406
.word    35980
.word    99607
.word    235068
.word    23620
.word    69654
.word    36155
.word    217828
.word    185521
.word    -168382
.word    -163864
.word    -130813
.word    128408
.word    -153442
.word    246300
.word    106916
.word    -165528
.word    182732
.word    208800
.word    235449
.word    36006
.word    32068
.word    -164903
.word    6976
.word    24721
.word    -170709
.word    -3115
.word    17910
.word    -153609
.word    62816
.word    -241580
.word    -92417
.word    16830
.word    -88346
.word    52117
.word    -70414
.word    -186191
.word    211045
.word    71685
.word    80975
.word    89419
.word    124725
.word    174511
.word    8495
.word    -177547
.word    -60861
.word    163720
.word    -167604
.word    -86713
.word    237901
.word    156210
.word    -141684
.word    254885
.word    -222494
.word    -38004
.word    -48788
.word    -50851
.word    -197920
.word    -38602
.word    57909
.word    248912
.word    -142851
.word    -74419
.word    -119217
.word    -106336
.word    -158922
.word    -243342
.word    -25804
.word    -130744
.word    188051
.word    14592
.word    211209
.word    241705
.word    43567
.word    -194323
.word    217532
.word    47716
.word    195644
.word    -38517
.word    54701
.word    -218911
.word    216634
.word    72461
.word    -201706
.word    102115
.word    -53140
.word    -211699
.word    -145616
.word    -128113
.word    -139407
.word    103532
.word    129618
.word    24116
.word    27277
.word    66592
.word    247584
.word    68482
.word    51232
.word    208686
.word    36127
.word    -83936
.word    233141
.word    -30639
.word    51787
.word    112334
.word    91177
.word    -146493
.word    -213372
.word    -115016
.word    187435
.word    30272
.word    -18040
.word    -35547
.word    139733
.word    78500
.word    80442
.word    -172880
.word    -34488
.word    2594
.word    -63581
.word    -10010
.word    -80365
.word    141345
.word    -59189
.word    107894
.word    -9724
.word    116882
.word    223156
.word    8800
.word    205565
.word    -143722
.word    190342
.word    -212827
.word    -17644
.word    -243816
.word    157223
.word    -163603
.word    -170650
.word    -162383
.word    97633
.word    -145981
.word    -102967
.word    136851
.word    587
.word    208827
.word    -225495
.word    -32257
.word    36850
.word    33184
.word    165147
.word    -190690
.word    -101941
.word    -253918
.word    230065
.word    135813
.word    128165
.word    -184179
.word    -76847
.word    -177817
.word    -1672
.word    157413
.word    67763
.word    96085
.word    71181
.word    116954
.word    183522
.word    64747
.word    -162899
.word    37386
.word    -171582
.word    207087
.word    -215556
.word    -82347
.word    41115
.word    -12630
.word    155714
.word    15697
.word    -139072
.word    106838
.word    -179198
.word    80639
.word    68331
.word    -138054
.word    -162064
.word    -170161
.word    -178701
.word    -151599
.word    232029
.word    -246887
.word    233333
.word    -241897
.word    240267
.word    -103226
.word    12787
.word    184793
.word    202167
.word    -158605
.word    81967
.word    225028
.word    242611
.word    -199953
.word    -163762
.word    125741
.word    -229772
.word    -218645
.word    -5546
.word    178446
.word    253492
.word    -252760
.word    21730
.word    184288
.word    208661
.word    176129
.word    193226
.word    125553
.word    -195081
.word    4601
.word    -168896
.word    168867
.word    218286
.word    -168563
.word    195706
.word    -57190
.word    -59890
.word    -116559
.word    187621
.word    123166
.word    -26585
.word    106916
.word    226609
.word    -166200
.word    -130256
.word    71874
.word    157393
.word    180220
.word    -51960
.word    -196099
.word    -214057
.word    -71162
.word    167742
.word    -145549
.word    148431
.word    78891
.word    -241666
.word    145746
.word    215508
.word    -3920
.word    170346
.word    -188010
.word    132490
.word    217126
.word    169681
.word    -122706
.word    -146359
.word    11381
.word    -52348
.word    -10654
.word    251891
.word    53284
.word    226904
.word    -4874
.word    -31647
.word    139055
.word    124474
.word    -29119
.word    -227970
.word    -210211
.word    151973
.word    79347
.word    -238509
.word    29104
.word    112099
.word    -198692
.word    -144510
.word    158621
.word    -184283
.word    194769
.word    216014
.word    -248495
.word    -62649
.word    -169416
.word    20514
.word    -203153
.word    -234974
.word    220947
.word    240512
.word    -70927
.word    73545
.word    -220347
.word    -148965
.word    -234802
.word    -15627
.word    -178451
.word    250567


m:
	.word	0

	.text
	.align	2
	.globl	__start
__start:
	li x16,2000       # put 7 in x16 
	la x4,v           # put in x4 the address of v
	la x5,m           # put in x5 the address of m
	li x13,0          # init x13 with max pos
loop:	
	beq x16,x0,done   # check all elements have been tested
	lw x8,0(x4)       # load new element in x8
	addi x4,x4,0x4	  # point to next element
	addi x16,x16,-1   # decrease remaining elements by 1
	slt x11,x8,x0     # x11 = (x8 < 0) ? 1 : 0 
	beq x11,x0,loop   # next element - if x8 > 0 then go straight else jmp 
	addi x13,x13,1    # update number of negatives
	jal loop          # next element
done:	
	sw x13,0(x5)      # store the result	
endc:	
	jal endc  	  # infinite loop
	addi x0,x0,0
