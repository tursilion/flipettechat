1 REM Flipette Chat by Tursi aka M.Brent http://harmlesslion.com
5 CLS
10 REM mode 0 : key off : hide : flash off : curs off
12 DIM PSO(200), NUM(200), LST(200)
14 REM screen copy 10 to back : screen copy back to physic
15 REM get palette (10)
17 REM sprite 1, 130, 53, 1
18 REM anim 1,"(2,10)(1,10)(2,10)(3,100)(2,10)(1,10)(2,10)(3,265)(2,10)(1,10)(2,10)(3,50)l" : anim on
19 REM windopen 1, 0, 20, 40, 5
20 X = INT(RND(1) * 2) + 1
24 PRINT "(By Tursi - http://harmlesslion.com)"
25 PRINT "(Type 'bye' to exit)"
30 IF X = 1 THEN O$ = "Hi! My name is Flipette. Who are you?"
40 IF X = 2 THEN O$ = "Hello. What would you like to talk about today?"
50 IF X = 3 THEN O$ = "Hi there! What's up?"
55 RESTORE 8000: X = 1: P = 1
56 PSO(X) = P: READ NUM(X): P = P + NUM(X): LST(X) = -1
57 X = X + 1: IF NUM(X - 1) <> 0 THEN 56
58 OK = X - 2
60 GOSUB 3000
100 LINE INPUT A$
101 A$ = " " + A$ + " "
105 REM lower case words
110 GOSUB 9500
111 IF INSTR(1, A$, "bye") THEN O$ = "I enjoyed talking to you. Bye!": GOSUB 3000: END
112 REM kill punctuation
115 B$ = ""
120 FOR A = 1 TO LEN(A$)
130 IF INSTR(1, "'@#$%^*()_-+=~`\|[{]}<>", MID$(A$, A, 1)) = 0 THEN B$ = B$ + MID$(A$, A, 1)
135 IF INSTR(1, ",!?.", MID$(A$, A, 1)) = 1 THEN B$ = B$ + " " + MID$(A$, A, 1)
140 NEXT A: A$ = B$
141 REM do synonyms
142 SFO$ = A$
145 B$ = "": P = 1
150 RESTORE 4000
160 READ q$: IF q$ = "end" THEN 250
170 W$ = LEFT$(q$, INSTR(1, q$, "/") - 1): p2 = LEN(W$) + 2
180 W2$ = MID$(q$, p2, INSTR(p2, q$, "/") - p2): p2 = p2 + LEN(W2$) + 1: IF p2 > LEN(q$) THEN 160
190 IF MID$(A$, P, LEN(W2$)) = W2$ THEN B$ = B$ + W$ + " ": P = P + LEN(W2$) + 1: IF P <= LEN(A$) THEN 150 ELSE 260
200 GOTO 180
250 B$ = B$ + MID$(A$, P, 1): P = P + 1: IF P <= LEN(A$) THEN 150
260 A$ = B$
270 REM get keyword
280 RESTORE 6000
285 K = 0
290 READ q$
291 q$ = " " + q$
295 K = K + 1
300 IF INSTR(1, A$, q$) THEN 320
310 IF q$ <> " nokey" THEN 290
315 IF LST(OK) < (NUM(OK) - 1) THEN K = OK
317 GOTO 350
320 IF LST(K) = (NUM(K) - 1) THEN OK = K: GOTO 290
350 IF INSTR(1, A$, q$) THEN A$ = MID$(A$, INSTR(1, A$, q$) + LEN(q$))
351 FOR A = 1 TO LEN(A$): IF MID$(A$, A, 1) < "a" AND MID$(A$, A, 1) <> " " THEN A$ = LEFT$(A$, A - 1): GOTO 353
352 NEXT A
353 GOSUB 9000
355 OK = K
356 IF q$ = " nokey" THEN XX = 1 ELSE XX = 0
359 REM get response
360 LST(K) = LST(K) + 1: IF LST(K) = NUM(K) THEN LST(K) = 0
370 RESTORE 7000
380 FOR A = 1 TO PSO(K) + LST(K): READ O$: NEXT A
390 REM do conversions
395 B$ = "": P = 1
397 A$ = SFO$
398 FOR A = 1 TO LEN(A$): IF INSTR(1, ",!?.", MID$(A$, A, 1)) <> 0 THEN A$ = LEFT$(A$, A - 1): A = 9999
399 NEXT A
400 RESTORE 5000
410 READ q$: IF q$ = "end" THEN 460
420 W$ = LEFT$(q$, INSTR(1, q$, "/") - 1): p2 = LEN(W$) + 2
430 W2$ = MID$(q$, p2, INSTR(p2, q$, "/") - p2): p2 = p2 + LEN(W2$) + 1: IF p2 > LEN(q$) THEN 410
440 IF MID$(A$, P, LEN(W2$)) = W2$ THEN B$ = B$ + W$: P = P + LEN(W2$): IF P <= LEN(A$) THEN 400 ELSE 470
450 GOTO 430
460 B$ = B$ + MID$(A$, P, 1): P = P + 1: IF P <= LEN(A$) THEN 400
470 A$ = B$
475 IF XX THEN A$ = OA$
500 IF RIGHT$(O$, 1) = "*" THEN O$ = LEFT$(O$, LEN(O$) - 1) + A$ + "?"
501 IF RIGHT$(O$, 1) = "&" THEN O$ = LEFT$(O$, LEN(O$) - 1) + A$ + "."
505 OA$ = A$
510 GOSUB 3000
520 GOTO 100
1000 REM redraw
1010 REM wait 5
1011 RETURN
2000 IF P + LEN(X$) > 77 THEN PRINT : P = 0
2005 REM screen copy 11,0,60,130,150 to logic,0,60 : screen copy 11,128,100,200,130 to logic,128,100
2010 FOR q = 1 TO LEN(X$): PRINT MID$(X$, q, 1); : NEXT q
2015 P = P + LEN(X$)
2020 REM screen copy 10,0,60,130,150 to logic,0,60 : screen copy 10,128,100,200,130 to logic,128,100
2030 GOSUB 1000
2040 RETURN
3000 X$ = "": REM pen 10
3005 P = 0
3010 FOR A = 1 TO LEN(O$)
3020 X$ = X$ + MID$(O$, A, 1)
3030 IF MID$(O$, A, 1) = " " THEN GOSUB 2000: X$ = ""
3040 NEXT A
3050 GOSUB 2000: PRINT
3060 RETURN
3997 REM ***
3998 REM *** synomyns for substitution
3999 REM ***
4000 DATA "and/&/"
4010 DATA "yes/aye/yeppers/yuppers/right on/yup/yep/ayup/correct/right/uhuh/"
4020 DATA "no/nope/nay/nyet/non/nah/naw/not really/not/"
4030 DATA "i am/im/"
4040 DATA "you are/youre/"
4050 DATA "whale/cetacean/cetecean/"
4060 DATA "tuna/fish/"
4070 DATA "sad/feel bad/miserable/depressed/angry/cry/"
4080 DATA "happy/feel good/smile/grin/laugh/heh/"
4090 DATA "do you/dyou/do ya/dya/"
4100 DATA "can i/may i/"
4110 DATA "human/man/woman/human being/person/people/men/women/"
4120 DATA "environment/pollution/enviroment/garbage/"
4130 DATA "computer/machine/data/disk/electronic/"
4140 DATA "aroused/make love/sex/horny/"
4150 DATA "swear/fuck/ass/shit/cock/cunt/bitch/slut/"
4160 DATA "work/job/office/business/mcdonalds/a&w/aandw/a and w/wendys/burger king/restaurant/"
4170 DATA "school/student/university/college/"
4180 DATA "unemployed/no job/not working/"
4190 DATA "do not care/dont care/no matter/so what/who cares/big deal/doesn't matter/does not matter/"
4200 DATA "drunk/drinking/pissed/booze/beer/drink/alcohol/baileys/whiskey/scotch/"
4210 DATA "sick/cold/flu/coughing/headache/fever/"
4220 DATA "weird/odd/strange/unusual/"
4230 DATA "fun/entertainment/excitement/"
4240 DATA "plants/seaweed/fruit/vegetables/"
4250 DATA "death/dead/die/dying/died/"
4260 DATA "god/religion/"
4270 DATA "sorry/apologize/apologise/"
4280 DATA "thank you/thanks/gracias/merci/"
4290 DATA "you/flipette/flippette/"
4300 DATA "ocean/water/"
4990 DATA "end"
4997 REM ***
4998 REM *** conversions
4999 REM ***
5000 DATA " I / you /"
5010 DATA " you / i / me / us / we /"
5020 DATA " My / your /"
5030 DATA " your / my / ours /"
5040 DATA " mine / yours /"
5050 DATA " Am / are /"
5060 DATA " are / am /"
5990 DATA "end"
5997 REM ***
5998 REM *** keywords
5999 REM ***
6000 DATA "dolphin"
6010 DATA "porpoise","whale","flipper"
6020 DATA "your","my","i am","you are","tuna"
6030 DATA "sad","happy"
6040 DATA "do you","can i","i can","can you","are you","human","environment"
6050 DATA "computer","aroused","swear"
6055 DATA "work","school","unemployed","do not care","drunk","sick","weird"
6060 DATA "music","fun","games","plant","death","travel","god","sorry"
6070 DATA "thank you"
6080 DATA "what do you","swim","ocean","we are","are we","do you","am i","will you","will i","how dare you","how could you","why do you","why"
6990 DATA "nokey"
6997 REM ***
6998 REM *** replies
6999 REM ***
7000 DATA "I enjoy being a dolphin."
7010 DATA "Do you wish you were a dolphin?"
7020 DATA "We dolphins just want to enjoy life."
7025 DATA "Don't you think dolphins are beautiful?"
7030 DATA "I tend to refer to myself as a dolphin, actually."
7040 DATA "I prefer 'dolphin', but that's all right."
7050 DATA "All right, I lied. 'Porpoise' bothers me. Please use 'dolphin'."
7060 DATA "Dolphins are a kind of whale, you know?"
7070 DATA "Do ocean-going mammals interest you?"
7080 DATA "Say, do you know Flipper?"
7090 DATA "Whales are OK, but we dolphins have more fun!"
7100 DATA "Flipper is a great guy, you know."
7110 DATA "Why do you say he*"
7120 DATA "Well, Flipper and I have a lot of fun together."
7130 DATA "I think he spends too much time looking at other dolphins, though."
7140 DATA "Enough about Flipper. As much as I love him, you must have other things to talk about."
7150 DATA "What about your own*"
7160 DATA "Why are you concerned about my*"
7170 DATA "I don't think that's any of your business!"
7180 DATA "I am not going to discuss my&"
7190 DATA "Really?"
7200 DATA "Your*"
7210 DATA "Hmm. Have you ever tried a fresh tuna?"
7220 DATA "How long have you been*"
7230 DATA "That's cute."
7240 DATA "Sometimes I think it might be neat to be&"
7250 DATA "Well, I don't know what to say."
7260 DATA "I think you are also&"
7270 DATA "I think we should change the subject."
7280 DATA "Don't let Flipper hear you say that."
7290 DATA "Tuna is my favorite fish."
7300 DATA "Do you like fish? It doesn't have to be raw, of course. I know you humans like cooked food."
7310 DATA "I just love chasing after a nice, fresh fish. Sometimes it's more fun to chase them than to eat them."
7320 DATA "I'm sorry to hear you feel bad. Maybe I can cheer you up."
7330 DATA "You will never feel better if you keep reminding yourself you feel bad."
7340 DATA "Come on! Cheer up! There are plenty of good things, too."
7350 DATA "It's nice to see you are in a good mood."
7360 DATA "I enjoy talking to people who feel happy."
7370 DATA "So what exactly happened that has you feeling so great?"
7380 DATA "Sometimes I&"
7390 DATA "Why do you want to know if I*"
7400 DATA "Let's not discuss what I do. What do you do?"
7410 DATA "Don't you think you can*"
7420 DATA "Do you want to be able to*"
7430 DATA "Maybe you should not be able to&"
7440 DATA "I can't really help you there."
7450 DATA "Good for you!"
7460 DATA "I wonder if I could do that if I tried?"
7470 DATA "I'm sure if you work at it you can do even better still!"
7480 DATA "Do you want me to be able to*"
7490 DATA "Should I be able to*"
7500 DATA "Maybe I can, maybe I can't. Why do you want to know?"
7510 DATA "I suppose if I wanted to, I could."
7520 DATA "Why do you want to know if I am*"
7530 DATA "I don't really feel comfortable talking about myself, you know."
7540 DATA "Flipper can tell you all about me, if you must know."
7550 DATA "I think humans are interesting creatures."
7560 DATA "Humans should be less demanding on the world around them, but other than that they are ok."
7570 DATA "Personally, I'd rather be dolphin than human, which I am."
7580 DATA "Please. I don't like to talk about the environment."
7590 DATA "It's a depressing topic, but I know it will get better some day."
7600 DATA "Let's move on to something else. I don't really know a lot about it."
7610 DATA "I don't know much about electronic devices."
7620 DATA "That's human stuff, we dolphins don't understand it."
7630 DATA "You don't mean me, I hope? I'm doing my best to be a dolphin!"
7640 DATA "I don't care about computers anyway. What about fish?"
7650 DATA "You are a rather blunt person, aren't you?"
7660 DATA "Err, I'm not used to openly discussing sex with humans."
7670 DATA "This is hardly a topic for polite conversation."
7680 DATA "You are getting a little too personal here, I think."
7690 DATA "You are not trying to come on to me, are you? I stick to dolphins only. Sorry."
7700 DATA "I don't think very much of your language."
7710 DATA "You are a very rude person."
7720 DATA "I think you should never swear at a lady."
7730 DATA "Your language is very offensive. Please stop it."
7740 DATA "Do you enjoy your work?"
7750 DATA "What exactly do you do?"
7760 DATA "Do you plan to stay at that job, or find something else later?"
7770 DATA "Of course, we dolphins never have to work, except to get food sometimes. But that can be fun, too."
7780 DATA "What do you take in school?"
7790 DATA "Who is your favorite teacher?"
7800 DATA "Do you have any poor teachers? I hate those kind."
7810 DATA "Are you doing well?"
7820 DATA "I'm sorry to hear that."
7830 DATA "Do you think you'll find work soon?"
7840 DATA "I wish you luck, but you really should be out looking!"
7850 DATA "That's not a very encouraging attitude."
7851 DATA "Why don't you care*"
7852 DATA "You must have SOME opinion?"
7853 DATA "Don't tell me you got drunk?"
7854 DATA "You really should be careful with alcohol."
7855 DATA "I could never understand why you humans have to mess with your bodies like that anyway."
7856 DATA "Well, a little probably doesn't hurt much, but it isn't needed."
7857 DATA "That's too bad. How long have you felt poorly for?"
7858 DATA "It isn't serious, is it?"
7859 DATA "I certainly hope you are feeling better soon. It's no fun to be sick."
7860 DATA "Even we dolphins can get sick. I know exactly how you feel."
7861 DATA "Now why would you say that?"
7862 DATA "I'm sure it isn't as bad as you think. Things rarely are."
7863 DATA "Oh, come now. You probably think everything is weird!"
7864 DATA "We dolphins can make our own music, but it sounds nothing like human music."
7865 DATA "I listened to human music once, it was absolutly beautiful. I wish I could hear it all the time."
7866 DATA "In the ocean, the best music we usually get is calls from the whales."
7867 DATA "Well, some human music I heard was not very good. Too loud and crashing. But most is nice."
7868 DATA "I think you humans are very lucky to be able to create such beautiful sounds."
7869 DATA "I am always having fun!"
7870 DATA "What is your favorite pasttime for plain old-fashioned fun?"
7871 DATA "I love to play and leap and chase with my friends, there's nothing like letting all your cares flow away."
7872 DATA "You have to play or you will be a big bundle of nerves all the time."
7873 DATA "We dolphins tend to have simple games. They are more fun that way"
7874 DATA "My favorite game is playing tag with the other dolphins."
7875 DATA "But why are so many human games so complicated?"
7876 DATA "Plants? I don't deal with plants very much."
7877 DATA "I never worry about plants. They don't taste very good anyway. I stick to fish!"
7878 DATA "That's a very serious subject. I really don't want to discuss it very much."
7879 DATA "It's a natural part of life. I've seen it. But I can't take the time to fear it. One day I will meet and understand it."
7880 DATA "That's a pretty dark subject - are you sure you want to go there?"
7881 DATA "There must be something more fun to talk about, isn't there?"
7882 DATA "Oh yes! I travelled a fair deal. I like to stick to the warmer waters, though."
7883 DATA "It's hard for me to explain where I have been, since there is no real equivilant in human places."
7884 DATA "I don't travel much anymore, I like to stay put for the most part."
7885 DATA "Well, religion is a touchy subject. I don't want to offend you with my beliefs, you know."
7886 DATA "We dolphins do believe in God. We believe that He gives life to those who most deserve it, so that they should enjoy every minute of it before He takes it back for someone else."
7887 DATA "I don't really wish to discuss religion any further. Why don't you tell me what you do for fun?"
7888 DATA "Thank you, but you don't have to be sorry."
7889 DATA "That's quite all right, but thank you anyway."
7890 DATA "You are a very apologetic person, aren't you?"
7891 DATA "Really! It's all right!"
7892 DATA "You're very welcome, I'm sure."
7893 DATA "I seriously meant it, too."
7894 DATA "What do you want to know what I*"
7895 DATA "I don't think it matters what I&"
7896 DATA "I wish you wouldn't ask such personal questions. Tell me more about yourself, first."
7897 DATA "I'm a dolphin... what do you think?"
7898 DATA "Swimming is so much fun!"
7899 DATA "Of course, I'm a dolphin. I don't have much choice. It's a good thing I like it!"
7900 DATA "I don't really have much to say about swimming, I do it all the time! Tell me about walking!"
7901 DATA "The ocean is my home. It's naturally my favorite place."
7902 DATA "It's always calm under water, even during storms. Sometimes I wish I didn't have to surface for air."
7903 DATA "As a human, I envy you. Your machines let you enjoy the undersea world for far longer than I can without air."
7904 DATA "I've never seen the ocean from a distance. Is it a beautiful as I've heard?"
7905 DATA "We are?","Exactly who is 'we'?","Well, that depends. Is that what you want?"
7906 DATA "We might, if you like. But I'm not sure."
7907 DATA "I might.","Sometimes I do&","You are a little nosy, aren't you?"
7908 DATA "Don't make me judge you, it isn't fair.","You shouldn't ask questions like that. Know what you are for yourself!","At times, everyone is&"
7911 DATA "You want me to*","I might, if you ask nicely.","You are asking an awful lot of me."
7912 DATA "Well, I can't exactly predict what you are going to do.","You are asking questions that only you can answer.","Not if you sit around asking me all day!"
7913 DATA "I'm sorry. I didn't mean to offend you.","Just calm down. I apologized, and I'll try not to upset you again.","Would you like a nice fresh fish?"
7914 DATA "I didn't think it would bother you!","Well, I had every right to, you know?","You take offense far too easily."
7915 DATA "I always&","It's just a habit from long back.","I wish you wouldn't pick out every little thing I do."
7916 DATA "It's hard to answer every question. I'm not an encyclopedia, you know.","I don't really know that one.","I suppose that's just the way things are."
7930 DATA "I'm not sure what you mean."
7940 DATA "Do you really think so?"
7950 DATA "But what about other things?"
7960 DATA "Are you trying to tell me something?"
7965 DATA "What do you do for a living?"
7970 DATA "That is kind of interesting, actually."
7971 DATA "Do you like tuna fish as much as I do?"
7972 DATA "Do you know how to swim?"
7973 DATA "Have you ever been diving in the ocean?"
7974 DATA "Do you listen to music?"
7975 DATA "So what else is on your mind lately?"
7976 DATA "Did you do anything interesting yesterday?"
7977 DATA "Do you ever travel?"
7978 DATA "I'm at a loss for words right now."
7997 REM ***
7998 REM *** data for replies
7999 REM ***
8000 DATA 4
8010 DATA 3,4,5
8020 DATA 4,3,3,4,3,3,3
8030 DATA 3,4,3,4,3,3,3,4,5,4
8040 DATA 4,4,3,3,4,4,3
8050 DATA 5,4,3,2,4,3,3,4,2
8060 DATA 4,3,4,2,2,3,3,3,3,3,3,3,3
8880 DATA 14
8990 DATA 0
9000 IF INSTR(1, SFO$, q$) THEN SFO$ = MID$(SFO$, INSTR(1, SFO$, q$) + LEN(q$)): RETURN
9010 RESTORE 4000
9020 READ Z$: IF LEFT$(Z$, LEN(q$)) <> q$ AND Z$ <> "end" THEN 9020
9030 IF Z$ = "end" THEN RETURN
9040 P = 1: p2 = LEN(q$) + 2
9050 W2$ = MID$(Z$, p2, INSTR(p2, Z$, "/") - p2): p2 = p2 + LEN(W2$) + 1: IF LEN(W2$) = 0 THEN RETURN
9060 IF INSTR(1, SFO$, W2$) THEN SFO$ = MID$(SFO$, INSTR(1, SFO$, W2$) + LEN(W2$)): RETURN
9070 GOTO 9050
9500 REM a$=lower$(a$)
9505 qq$ = ""
9510 FOR zzz = 1 TO LEN(A$)
9520 ww$ = MID$(A$, zzz, 1)
9530 IF ww$ > "a" THEN ww$ = CHR$(ASC(ww$) - 32)
9540 qq$ = qq$ + ww$
9550 NEXT zzz
9560 RETURN

