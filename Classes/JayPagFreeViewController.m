//
//  JayPagFreeViewController.m
//  JayPagFree
//
//  Created by Carlo Macor on 29/01/10.
//  Copyright Carlo Macor 2010. All rights reserved.
//

#import "JayPagFreeViewController.h"

typedef enum {
	kstate_run2giochi,kstate_prerun2giochi,
	kstate_up15,    kstate_upjp,
	kstate_down15,  kstate_downjp,
	kstate_open15,  kstate_openjp,
	kstate_close15, kstate_closejp,
	kstate_run15,   kstate_runjp,
	kstate_openMenu15,
	kstate_openMenujp,
	kstate_closemenu,
	
	kstate_MenuRun15,
	kstate_MenuRunjp,
	kstate_InfoOpen,	    kstate_Info,          kstate_InfoClose,
    kstate_close15jp,
	kstate_RecordOpen,	    kstate_Record,        kstate_RecordClose,
	
	kstate_TutorialOpen,    kstate_Tutorial,      kstate_TutorialClose,
	kstate_SolvedOpen,      kstate_SolvedRun,
	
	kstate_inGame15, kstate_inGamejp, kstate_gameover
}  gameStates;



@interface JayPagFreeViewController (private)

- (void) fissavariabili;

- (void) p_EndMenuClose;
- (void) p_StartInfoOpen;
- (void) p_StartRecordsOpen;
- (void) p_StarttutorialOpen ;
- (void) scrivitime               : (int) time  ;
- (int)  testmovejp               : (int) dir   ;
- (bool) b_serisolto15;
- (bool) b_serisoltojp;
- (void) riposizionatutte15 ;
- (void) riposizionatuttejp ;

@end



@implementation JayPagFreeViewController


@synthesize  gameState ;
@synthesize  sceltamenu ;


- (void) setupnomikey                                {
	
	Key_intrecords15[0]  =@"A00";
	Key_intrecords15[1]  =@"A01";
	Key_intrecords15[2]  =@"A02";
	Key_intrecords15[3]  =@"A03";
	Key_intrecords15[4]  =@"A04";
	Key_intrecords15[5]  =@"A05";
	Key_intrecords15[6]  =@"A06";
	Key_intrecords15[7]  =@"A07";
	Key_intrecords15[8]  =@"A08";
	Key_intrecords15[9]  =@"A09";
	
	Key_intrecordsjp[0] =@"B00";
	Key_intrecordsjp[1] =@"B01";
	Key_intrecordsjp[2] =@"B02";
	Key_intrecordsjp[3] =@"B03";
	Key_intrecordsjp[4] =@"B04";
	Key_intrecordsjp[5] =@"B05";
	Key_intrecordsjp[6] =@"B06";
	Key_intrecordsjp[7] =@"B07";
	Key_intrecordsjp[8] =@"B08";
	Key_intrecordsjp[9] =@"B09";
	
	Key_primaapertura   =@"I01";
	Key_intvolume       =@"I02";
	Key_time15          =@"K01";
	Key_timejp          =@"K02";
	
	
	
	Key_posx15 [0]   =@"X00"; 
	Key_posx15 [1]   =@"X01"; 
	Key_posx15 [2]   =@"X02"; 
	Key_posx15 [3]   =@"X03"; 
	Key_posx15 [4]   =@"X04"; 
	Key_posx15 [5]   =@"X05"; 
	Key_posx15 [6]   =@"X06"; 
	Key_posx15 [7]   =@"X07"; 
	Key_posx15 [8]   =@"X08"; 
	Key_posx15 [9]   =@"X09"; 
	Key_posx15 [10]  =@"X10"; 
	Key_posx15 [11]  =@"X11"; 
	Key_posx15 [12]  =@"X12"; 
	Key_posx15 [13]  =@"X13"; 
	Key_posx15 [14]  =@"X14"; 
	Key_posx15 [15]  =@"X15"; 
	
	Key_posy15 [0]   =@"Y00"; 
	Key_posy15 [1]   =@"Y01"; 
	Key_posy15 [2]   =@"Y02"; 
	Key_posy15 [3]   =@"Y03"; 
	Key_posy15 [4]   =@"Y04"; 
	Key_posy15 [5]   =@"Y05"; 
	Key_posy15 [6]   =@"Y06"; 
	Key_posy15 [7]   =@"Y07"; 
	Key_posy15 [8]   =@"Y08"; 
	Key_posy15 [9]   =@"Y09"; 
	Key_posy15 [10]  =@"Y10"; 
	Key_posy15 [11]  =@"Y11"; 
	Key_posy15 [12]  =@"Y12"; 
	Key_posy15 [13]  =@"Y13"; 
	Key_posy15 [14]  =@"Y14"; 
	Key_posy15 [15]  =@"Y15"; 
	
	Key_posxjp [0]   =@"Z00"; 
	Key_posxjp [1]   =@"Z01"; 
	Key_posxjp [2]   =@"Z02"; 
	Key_posxjp [3]   =@"Z03"; 
	Key_posxjp [4]   =@"Z04"; 
	Key_posxjp [5]   =@"Z05"; 
	Key_posxjp [6]   =@"Z06"; 
	Key_posxjp [7]   =@"Z07"; 
	Key_posxjp [8]   =@"Z08"; 
	Key_posxjp [9]   =@"Z09"; 
	Key_posxjp [10]  =@"Z10"; 
	Key_posxjp [11]  =@"Z11"; 
	
	Key_posyjp [0]   =@"W00"; 
	Key_posyjp [1]   =@"W01"; 
	Key_posyjp [2]   =@"W02"; 
	Key_posyjp [3]   =@"W03"; 
	Key_posyjp [4]   =@"W04"; 
	Key_posyjp [5]   =@"W05"; 
	Key_posyjp [6]   =@"W06"; 
	Key_posyjp [7]   =@"W07"; 
	Key_posyjp [8]   =@"W08"; 
	Key_posyjp [9]   =@"W09"; 
	Key_posyjp [10]  =@"W10"; 
	Key_posyjp [11]  =@"W11"; 
	
}

- (void) setupvariabili                              {
	pos15x[0] =0;	pos15y[0] =0;
	pos15x[1] =1;	pos15y[1] =0;
	pos15x[2] =2;	pos15y[2] =0;
	pos15x[3] =3;	pos15y[3] =0;
	
	pos15x[4] =0;	pos15y[4] =1;
	pos15x[5] =1;	pos15y[5] =1;
	pos15x[6] =2;	pos15y[6] =1;
	pos15x[7] =3;	pos15y[7] =1;
	
	pos15x[8] =0;	pos15y[8] =2;
	pos15x[9] =1;	pos15y[9] =2;
	pos15x[10]=2;	pos15y[10]=2;
	pos15x[11]=3;	pos15y[11]=2;
	
	pos15x[12]=0;	pos15y[12]=3;
	pos15x[13]=1;	pos15y[13]=3;
	pos15x[14]=2;	pos15y[14]=3;
	pos15x[15]=3;	pos15y[15]=3;
	
	
	for (int i=0; i<16; i++) {  posfinale15x[i]=pos15x[i];	  posfinale15y[i]=pos15y[i];   }
	
	
	posjpx[0] =3;	posjpy[0] =1;
	posjpx[1] =1;	posjpy[1] =0;
	posjpx[2] =3;	posjpy[2] =0;
	posjpx[3] =1;	posjpy[3] =3;
	posjpx[4] =3;	posjpy[4] =3;
	posjpx[5] =1;	posjpy[5] =1;
	posjpx[6] =0;	posjpy[6] =0;
	posjpx[7] =0;	posjpy[7] =1; 
	posjpx[8] =0;	posjpy[8] =2; 
	posjpx[9] =0;	posjpy[9] =3;
	
	posjpx[10] =2;	posjpy[10] =1;  // le vuote
	posjpx[11] =2;	posjpy[11] =2;
	
	for(int i=0; i<10   ;i++)  {   i_record15[i];   i_recordjp[i];  };
	
    f_scale15 = 0.6;
    f_scalejp = 0.6;
	
	i_pedina15=-1;
	i_pedinajp=-1;
	
	i_UltimoRecord15=20;
	i_UltimoRecordjp=20;
    b_usedrecord15=NO;
    b_usedrecordjp=NO;
	
	f_volindice[0]=100.0; // alto
	f_volindice[1]=100.0; // alto // bonus
	f_volindice[2]=100.0; // alto
	f_volindice[3]=100.0; // meno
	f_volindice[4]=100.0;
	
	b_clicked=NO;
	b_gameOver15=NO;
	b_gameOverjp=NO;
	
	i_contamossejp=110;
	
}

- (void) settavolumi                                 {
	for (int i=0; i<NUMSOUNDS; i++) { 
		effectPlayer[i].volume=(f_soundlevel*f_volindice[i])/10000;
	}
}

- (void) initSound                                   {
	NSBundle *mainBundle1 = [NSBundle mainBundle];
	NSBundle *mainBundle2 = [NSBundle mainBundle];
	NSBundle *mainBundle3 = [NSBundle mainBundle];
	NSBundle *mainBundle4 = [NSBundle mainBundle];
	NSBundle *mainBundle5 = [NSBundle mainBundle];
	NSURL *tickURL[NUMSOUNDS];
	
	tickURL[0]      = [NSURL fileURLWithPath:[mainBundle1 pathForResource:@"up_15"        ofType:@"caf"]];  
	tickURL[1]      = [NSURL fileURLWithPath:[mainBundle2 pathForResource:@"up_15"        ofType:@"caf"]];  
	tickURL[2]      = [NSURL fileURLWithPath:[mainBundle3 pathForResource:@"up_15"        ofType:@"caf"]];           
	tickURL[3]      = [NSURL fileURLWithPath:[mainBundle4 pathForResource:@"up_15"        ofType:@"caf"]];           
	tickURL[4]      = [NSURL fileURLWithPath:[mainBundle5 pathForResource:@"EndJayPag"    ofType:@"caf"]];           
	
	for (int i=0; i<NUMSOUNDS; i++) {  
		effectPlayer[i] = [[AVAudioPlayer alloc] initWithContentsOfURL:tickURL[i] error:nil];
		effectPlayer[i].volume=0.70;
		[effectPlayer[i] prepareToPlay];  }
	
	for(int i=0; i<NUMSOUNDS   ;i++)  { tickURL[i]=nil;}
	
	[mainBundle1 release];
	[mainBundle2 release];
	[mainBundle3 release];
	[mainBundle4 release];
	[mainBundle5 release];
	[self settavolumi];
}

- (void) Suona2                           : (int) ind {
	if (ind<4) {  i_contasound++; if (i_contasound>3) { i_contasound=0;}  ind=i_contasound;  }
	
	[ effectPlayer[ind]     play];
}

- (void) fissavariabili                              {	
	for (int i=0; i<10; i++) { 
		[[NSUserDefaults standardUserDefaults] setInteger:i_record15[i]   forKey:Key_intrecords15[i] ];	
		[[NSUserDefaults standardUserDefaults] setInteger:i_recordjp[i]   forKey:Key_intrecordsjp[i] ];	
	}
	[[NSUserDefaults standardUserDefaults] setInteger:i_timegioco15       forKey:Key_time15          ];	
	[[NSUserDefaults standardUserDefaults] setInteger:i_timegiocojp       forKey:Key_timejp          ];	
	b_primaapertura=YES;
	[[NSUserDefaults standardUserDefaults] setBool:b_primaapertura        forKey:Key_primaapertura   ];
	[[NSUserDefaults standardUserDefaults] setFloat:f_soundlevel          forKey:Key_intvolume       ];
	
	// qui le posizioni attuali di gioco
	for (int i=0; i<16; i++) { 
		[[NSUserDefaults standardUserDefaults] setInteger:pos15x[i]       forKey:Key_posx15[i]       ];	
		[[NSUserDefaults standardUserDefaults] setInteger:pos15y[i]       forKey:Key_posy15[i]       ];
	} 
	for (int i=0; i<12; i++) { 
		[[NSUserDefaults standardUserDefaults] setInteger:posjpx[i]       forKey:Key_posxjp[i]       ];	
		[[NSUserDefaults standardUserDefaults] setInteger:posjpy[i]       forKey:Key_posyjp[i]       ];
	} 
}         // salvataggio dati

- (void) Inverti_fissavariabili                      {
	
	b_primaapertura  = [[NSUserDefaults standardUserDefaults] boolForKey:Key_primaapertura ];
	if (!b_primaapertura) return;
	
	for (int i=0; i<10; i++) { 
		i_record15[i]      = [[NSUserDefaults standardUserDefaults] integerForKey:Key_intrecords15 [i] ];
		i_recordjp[i]      = [[NSUserDefaults standardUserDefaults] integerForKey:Key_intrecordsjp [i] ];
	}
	
	i_timegioco15      = [[NSUserDefaults standardUserDefaults] integerForKey:Key_time15 ];
	i_timegiocojp      = [[NSUserDefaults standardUserDefaults] integerForKey:Key_timejp ];
	
	f_soundlevel     = [[NSUserDefaults standardUserDefaults] floatForKey:Key_intvolume   ];
	
	if (f_soundlevel>0)  View_sound.highlighted=NO; else View_sound.highlighted=YES;
	
	
	for (int i=0; i<16; i++) { 
		pos15x[i]      = [[NSUserDefaults standardUserDefaults] integerForKey:Key_posx15 [i] ];
		pos15y[i]      = [[NSUserDefaults standardUserDefaults] integerForKey:Key_posy15 [i] ];
	}
	
	for (int i=0; i<12; i++) { 
		posjpx[i]      = [[NSUserDefaults standardUserDefaults] integerForKey:Key_posxjp [i] ];
		posjpy[i]      = [[NSUserDefaults standardUserDefaults] integerForKey:Key_posyjp [i] ];
	}
	
	
	
}

- (int) dimmiposxscheda                  : (int) ind {
	int locres=0;
	if (ind<0) {ind=0;}
	if (ind>15) {ind=15;}
	locres = img_base15.size.width/2+pos15x[ind]*dimxscheda15-dimxscheda15-dimxscheda15/2;
	return locres;
}

- (int) dimmiposyscheda                  : (int) ind {
	int locres=0;
	if (ind<0) {ind=0;}
	if (ind>15) {ind=15;}
	locres = img_base15.size.height/2+pos15y[ind]*dimyscheda15-dimyscheda15-dimyscheda15/2;
	return locres;
}

- (int) dimmiposxschedajp                : (int) ind {
	int locres=0;
	if (ind<0)  {ind=0;}	if (ind>11) {ind=11;}
	switch (ind) {
		case 0  :   	locres = img_basejp.size.width/2+posjpx[ind]*dimxscheda15-dimxscheda15-dimxscheda15/2;	break;  
		case 1  :  case 2  :   	case 3  :   	case 4  :   	
			locres = img_basejp.size.width/2+posjpx[ind]*dimxscheda15-dimxscheda15-dimxscheda15/2;	break;  
		case 5  :   	locres = img_basejp.size.width/2+posjpx[ind]*dimxscheda15-dimxscheda15*2;	            break;  
		case 6  :  case 7  :   	case 8  :   	case 9  :   case 10  :   case 11  :	
			locres = img_basejp.size.width/2+posjpx[ind]*dimxscheda15-dimxscheda15*2;	            break;
		default :		locres = img_base15.size.width/2+posjpx[ind]*dimxscheda15-dimxscheda15-dimxscheda15/2;  break;
			
	}
	return locres;
}

- (int) dimmiposyschedajp                : (int) ind {
	int locres=0;
	if (ind<0)  {ind=0;}	if (ind>11) {ind=11;}
	switch (ind) {
		case 0  :   	locres = img_basejp.size.height/2+posjpy[ind]*dimyscheda15-dimyscheda15;	            break; 
		case 1  :  case 2  :   	case 3  :   	case 4  :   	
			locres = img_basejp.size.height/2+posjpy[ind]*dimyscheda15-dimyscheda15-dimyscheda15/2;	break;
		case 5  :   	locres = img_basejp.size.height/2+posjpy[ind]*dimyscheda15-dimyscheda15;	            break;  
		case 6  :  case 7  :   	case 8  :   	case 9  :  case 10  :   case 11  :	 	
			locres = img_basejp.size.height/2+posjpy[ind]*dimyscheda15-dimyscheda15-dimyscheda15/2; break;
		default :		locres = img_basejp.size.height/2+posjpy[ind]*dimyscheda15-dimyscheda15-dimyscheda15/2; break;
	}
	return locres;
}

- (void) loadgraficadigits                           {
	img_digits[0]   = [UIImage imageNamed:@"d00.png"];	
	img_digits[1]   = [UIImage imageNamed:@"d01.png"];	
	img_digits[2]   = [UIImage imageNamed:@"d02.png"];	
	img_digits[3]   = [UIImage imageNamed:@"d03.png"];	
	img_digits[4]   = [UIImage imageNamed:@"d04.png"];	
	img_digits[5]   = [UIImage imageNamed:@"d05.png"];	
	img_digits[6]   = [UIImage imageNamed:@"d06.png"];	
	img_digits[7]   = [UIImage imageNamed:@"d07.png"];	
	img_digits[8]   = [UIImage imageNamed:@"d08.png"];	
	img_digits[9]   = [UIImage imageNamed:@"d09.png"];	
	img_digits[10]  = [UIImage imageNamed:@"d10.png"];	
	img_digits[11]  = [UIImage imageNamed:@"d11.png"];	
}

- (void) loadgraficagameJayPag                       {
	
	CGPoint locpt; 
	
	
	img_basejp            = [UIImage imageNamed:@"basejp.png"];	
	img_schedajp[0]       = [UIImage imageNamed:@"but01.png"];	img_schedajph[0]       = [UIImage imageNamed:@"but01h.png"];
	img_schedajp[1]       = [UIImage imageNamed:@"but02.png"];	img_schedajph[1]       = [UIImage imageNamed:@"but02h.png"];
	img_schedajp[2]       = [UIImage imageNamed:@"but03.png"];	img_schedajph[2]       = [UIImage imageNamed:@"but03h.png"];
	img_schedajp[3]       = [UIImage imageNamed:@"but04.png"];	img_schedajph[3]       = [UIImage imageNamed:@"but04h.png"];
	
	
	dimxschedajp  = img_schedajp[3].size.width;
	dimyschedajp  = img_schedajp[3].size.height;
	
	
	//	View_overschedajp[0]  = [UIImage imageNamed:@"but01h.png"];
	View_supportojp = [[UIImageView alloc] initWithImage: img_basejp];	View_supportojp.image=nil;
	[Pagina2 addSubview: View_supportojp];	
	
	View_basejp  = [[UIImageView alloc] initWithImage: img_basejp]; 
	[View_supportojp addSubview:View_basejp ];	    View_basejp.alpha=0.80;
	
	locpt.x=340;     locpt.y=174;
	View_supportojp.center=locpt;
	View_supportojp.transform=  CGAffineTransformMakeScale(f_scalejp, f_scalejp);
	
	
	View_schedajp[0]  = [[UIImageView alloc] initWithImage: img_schedajp[0]   highlightedImage: img_schedajph[0] ]; 
	View_schedajp[1]  = [[UIImageView alloc] initWithImage: img_schedajp[1]   highlightedImage: img_schedajph[1] ]; 
	View_schedajp[2]  = [[UIImageView alloc] initWithImage: img_schedajp[1]   highlightedImage: img_schedajph[1] ]; 
	View_schedajp[3]  = [[UIImageView alloc] initWithImage: img_schedajp[1]   highlightedImage: img_schedajph[1] ]; 
	View_schedajp[4]  = [[UIImageView alloc] initWithImage: img_schedajp[1]   highlightedImage: img_schedajph[1] ]; 
	View_schedajp[5]  = [[UIImageView alloc] initWithImage: img_schedajp[2]   highlightedImage: img_schedajph[2] ]; 
	View_schedajp[6]  = [[UIImageView alloc] initWithImage: img_schedajp[3]   highlightedImage: img_schedajph[3] ]; 
	View_schedajp[7]  = [[UIImageView alloc] initWithImage: img_schedajp[3]   highlightedImage: img_schedajph[3] ]; 
	View_schedajp[8]  = [[UIImageView alloc] initWithImage: img_schedajp[3]   highlightedImage: img_schedajph[3] ]; 
	View_schedajp[9]  = [[UIImageView alloc] initWithImage: img_schedajp[3]   highlightedImage: img_schedajph[3] ]; 
	
	View_schedajp[10] = [[UIImageView alloc] initWithImage: img_scheda15   ]; 
	View_schedajp[11] = [[UIImageView alloc] initWithImage: img_scheda15h   ]; 
	
	View_schedajp[10].hidden=YES;	View_schedajp[11].hidden=YES;
	
	
	for(int i=0; i<12   ;i++)  {
		[View_supportojp addSubview:View_schedajp[i] ];	  
		locpt.x=[self dimmiposxschedajp:i];
		locpt.y=[self dimmiposyschedajp:i];
		View_schedajp[i].center=locpt;
	}
	
	// ora i disegni sulle schede
	img_overschedajph[0] = [UIImage imageNamed:@"ov.png"];
	img_overschedajph[1] = [UIImage imageNamed:@"ov1.png"];
	img_overschedajph[2] = [UIImage imageNamed:@"ov2.png"];
	img_overschedajph[3] = [UIImage imageNamed:@"ov1.png"];
	img_overschedajph[4] = [UIImage imageNamed:@"ov2.png"];
	img_overschedajph[5] = [UIImage imageNamed:@"ov3.png"];
	img_overschedajph[6] = [UIImage imageNamed:@"ov4.png"];
	img_overschedajph[7] = [UIImage imageNamed:@"ov5.png"];
	img_overschedajph[8] = [UIImage imageNamed:@"ov6.png"];
	img_overschedajph[9] = [UIImage imageNamed:@"ov7.png"];
	
	for(int i=0; i<10   ;i++)  {
		View_overschedajp[i] = [[UIImageView alloc] initWithImage: img_overschedajph[i]  ];	
        [View_schedajp[i] addSubview:View_overschedajp[i] ];	
	}
	
	locpt.x=img_schedajp[0].size.width/2;     locpt.y=img_schedajp[0].size.height/2;	View_overschedajp[0].center=locpt;
	locpt.x=img_schedajp[1].size.width/2;     locpt.y=img_schedajp[1].size.height/2;	View_overschedajp[1].center=locpt;
	locpt.x=img_schedajp[1].size.width/2;     locpt.y=img_schedajp[1].size.height/2;	View_overschedajp[2].center=locpt;
	locpt.x=img_schedajp[1].size.width/2;     locpt.y=img_schedajp[1].size.height/2;	View_overschedajp[3].center=locpt;
	locpt.x=img_schedajp[1].size.width/2;     locpt.y=img_schedajp[1].size.height/2;	View_overschedajp[4].center=locpt;
	locpt.x=img_schedajp[2].size.width/2;     locpt.y=img_schedajp[2].size.height/2;	View_overschedajp[5].center=locpt;
	locpt.x=img_schedajp[3].size.width/2;     locpt.y=img_schedajp[3].size.height/2;	View_overschedajp[6].center=locpt;
	locpt.x=img_schedajp[3].size.width/2;     locpt.y=img_schedajp[3].size.height/2;	View_overschedajp[7].center=locpt;
	locpt.x=img_schedajp[3].size.width/2;     locpt.y=img_schedajp[3].size.height/2;	View_overschedajp[8].center=locpt;
	locpt.x=img_schedajp[3].size.width/2;     locpt.y=img_schedajp[3].size.height/2;	View_overschedajp[9].center=locpt;
	
	
	
	////////////////////////////////     DEMO	

	labdemojp = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 400.0, 60.0)];
	labdemojp.textColor = [UIColor blackColor];
	labdemojp.backgroundColor = [UIColor clearColor];
	labdemojp.textAlignment = UITextAlignmentCenter;	
	[Pagina2  addSubview: labdemojp];	
	locpt.x=210;
	locpt.y=306;
	labdemojp.center=locpt;
	labdemojp.text=@"This Free Version is Limited, Moves Count Down : "; 
	
	labcontamosse = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 100.0, 60.0)];
	labcontamosse.textColor = [UIColor blackColor];
	labcontamosse.backgroundColor = [UIColor clearColor];
	labcontamosse.textAlignment = UITextAlignmentCenter;	
	[Pagina2  addSubview: labcontamosse];	
	locpt.x=440;
	locpt.y=306;
	labcontamosse.center=locpt;
	labcontamosse.text=@"110"; 
	
	CGRect frame = CGRectMake(40.0, 12.0, 260.0, 90);
	frame.origin.x=198.0;   frame.origin.y=12.0;
	frame.size.width=260.0;	frame.size.height=30.0;
	comprafinale = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	comprafinale.frame = frame;
	[comprafinale setTitle:@"Buy JayPag Full Version" forState:UIControlStateNormal];
	comprafinale.backgroundColor = [UIColor clearColor];
	[comprafinale addTarget:self action:@selector(buttonaction:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview: comprafinale];	
	locpt.x=240;	    locpt.y=20;  
	comprafinale.center=locpt;

		labdemojp.hidden=YES;
		labcontamosse.hidden=YES;
    	comprafinale.hidden=YES;
	
////////////////////////////////     DEMO		
	
	
	img_solved = [UIImage imageNamed:@"solved.png"];
	View_solved= [[UIImageView alloc] initWithImage: img_solved];
	[Pagina2 addSubview: View_solved];	
	locpt.x=480/2;     locpt.y=320/2;	View_solved.center=locpt;
	View_solved.hidden=YES;
	
}   // Jay Pag e "Solved"

- (void) loadlabelrecords                            {
	CGPoint locpt;	
	
	for(int i=0; i<10   ;i++)  {
		Label_records15[i] = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 300.0, 60.0)];
		Label_records15[i].textColor = [UIColor yellowColor];
		Label_records15[i].backgroundColor = [UIColor clearColor];
		Label_records15[i].textAlignment = UITextAlignmentCenter;	
		[View_panel addSubview: Label_records15[i]];	
		Label_records15[i].hidden=YES;
		locpt.x=120;
		locpt.y=80+i*18;
		Label_records15[i].center=locpt;
		Label_records15[i].text=@"---"; 
	}
	
	for(int i=0; i<10   ;i++)  {
		Label_recordsjp[i] = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 300.0, 60.0)];
		Label_recordsjp[i].textColor = [UIColor yellowColor];
		Label_recordsjp[i].backgroundColor = [UIColor clearColor];
		Label_recordsjp[i].textAlignment = UITextAlignmentCenter;	
		[View_panel addSubview: Label_recordsjp[i]];	
		Label_recordsjp[i].hidden=YES;
		locpt.x=300;
		locpt.y=80+i*18;
		Label_recordsjp[i].center=locpt;
		Label_recordsjp[i].text=@"---"; 
	}
	
}

- (void) mettirecords                                {
	int entrance=20;
	int valuerecord;
	// punteggio  i_record15[i]  i_timegioco15
	
	if ((b_infase15) & (!b_usedrecord15)) {
		valuerecord=i_timegioco15;
		for (int i=9; i>=0; i--) { if (i_record15[i]==0) { entrance=i; i_UltimoRecord15=entrance;    }	}
		for (int i=9; i>=0; i--) { if (valuerecord<i_record15[i]) { entrance=i; i_UltimoRecord15=entrance;    }	}
		
		if (entrance<10){
			i_introducedrecord15=entrance;
			for (int i=9; i>entrance; i--) {  if (i>0) {i_record15[i]=i_record15[i-1];  } }
			i_record15[entrance]	= valuerecord;
		}
		b_usedrecord15=YES;
	}
	
	if ((!b_infase15) & (!b_usedrecordjp)){
		valuerecord=i_timegiocojp;
		for (int i=9; i>=0; i--) { if (i_recordjp[i]==0) { entrance=i; i_UltimoRecordjp=entrance;    }	}
		for (int i=9; i>=0; i--) { if (valuerecord<i_recordjp[i]) { entrance=i; i_UltimoRecordjp=entrance;    }	}
		if (entrance<10){
			i_introducedrecordjp=entrance;
			for (int i=9; i>entrance; i--) {  if (i>0) {i_recordjp[i]=i_recordjp[i-1];  } }
			i_recordjp[entrance]	= valuerecord;
		}
		b_usedrecordjp=YES;
	}
	
	[self fissavariabili];
}   // metto records

- (void) mettitestorecord                            {
	div_t locvalue; 	int secondi;	int minuti;	int ore; int tempo;
	for(int i=0; i<10   ;i++)  {Label_records15[i].hidden=NO; Label_recordsjp[i].hidden=NO; }
	for(int i=0; i<10   ;i++)  {
		tempo = i_record15[i];
		if ( tempo==0) continue;
		tempo= tempo / 30;
		locvalue = div(tempo ,60);
		secondi = locvalue.rem;  	minuti  = locvalue.quot;
		tempo  = locvalue.quot;
		locvalue = div(tempo ,60);
		minuti  = locvalue.rem; 	ore = locvalue.quot;
		STR_loctime = @"";
		if (ore>0)  STR_loctime = [STR_loctime stringByAppendingFormat:	 @"%d° : %d' : %d''", ore, minuti, secondi];
		else STR_loctime = [STR_loctime stringByAppendingFormat:	 @"%d' : %d''", minuti, secondi];
		Label_records15[i].text=STR_loctime;
		Label_records15[i].textColor = [UIColor blackColor];
	}	
	for(int i=0; i<10   ;i++)  {
		tempo = i_recordjp[i];
		if ( tempo==0) continue;
		tempo= tempo / 30;
		locvalue = div(tempo ,60);
		secondi = locvalue.rem;  	minuti  = locvalue.quot;
		tempo  = locvalue.quot;
		locvalue = div(tempo ,60);
		minuti  = locvalue.rem; 	ore = locvalue.quot;
		STR_loctime = @"";
		if (ore>0)  STR_loctime = [STR_loctime stringByAppendingFormat:	 @"%d° : %d' : %d''", ore, minuti, secondi];
		else STR_loctime = [STR_loctime stringByAppendingFormat:	 @"%d' : %d''", minuti, secondi];
		Label_recordsjp[i].text=STR_loctime;
		Label_recordsjp[i].textColor = [UIColor blackColor];
	}	
	
	if (b_infase15) { if (i_UltimoRecord15<10) 	Label_records15[i_UltimoRecord15].textColor = [UIColor whiteColor];  } else 
	{ if (i_UltimoRecordjp<10) 	Label_recordsjp[i_UltimoRecordjp].textColor = [UIColor whiteColor];  };
	
}

- (void) loadgraficagamebase15                       {
	CGRect  fr;	    
	CGPoint locpt; 
	
	img_sfondo   = [UIImage imageNamed:@"sfondo.png"];	
	View_sfondo  = [[UIImageView alloc] initWithImage: img_sfondo]; 
	[self.view addSubview: View_sfondo];	
	
	img_back     = [UIImage imageNamed:@"back.png"];	
	img_backh    = [UIImage imageNamed:@"backh.png"];	
	View_back    = [[UIImageView alloc] initWithImage: img_back   highlightedImage: img_backh ]; 
	View_backpanel = [[UIImageView alloc] initWithImage: img_back   highlightedImage: img_backh ]; // nel pannello info e record
    [View_sfondo addSubview: View_back];
	locpt.x=446; locpt.y=26;
	View_back.center=locpt;
	View_back.hidden=YES;
	
	img_sound     = [UIImage imageNamed:@"vup.png"];	
	img_soundh    = [UIImage imageNamed:@"vdown.png"];	
	View_sound    = [[UIImageView alloc] initWithImage: img_sound   highlightedImage: img_soundh ]; 
    [View_sfondo addSubview: View_sound];
	locpt.x=46; locpt.y=26;
	View_sound.center=locpt;
	View_sound.hidden=YES;
	
	
	
	fr.origin.x=0;      	fr.origin.y=0;
	fr.size.width=480;	    fr.size.height=320;
	
	Pagina1 = [[UIImageView alloc] initWithFrame:fr];    Pagina1.image=nil;   Pagina1.hidden=NO;  // gioco 15
	[self.view addSubview: Pagina1];	
	Pagina2 = [[UIImageView alloc] initWithFrame:fr];    Pagina2.image=nil;   Pagina2.hidden=NO;  // gioco jp
	[self.view addSubview: Pagina2];	
	Pagina3 = [[UIImageView alloc] initWithFrame:fr];    Pagina3.image=nil;   Pagina3.hidden=NO;   // menu
	[self.view addSubview: Pagina3];	
	
	img_sottotime15     = [UIImage imageNamed:@"opz15h.png"];	
	img_sottotimejp     = [UIImage imageNamed:@"opzjph.png"];	
	
	View_sottotime   = [[UIImageView alloc] initWithImage: img_sottotime15 highlightedImage: img_sottotimejp  ]; 
	[View_sfondo addSubview: View_sottotime];	
	locpt.x=240;	locpt.y=20;  	View_sottotime.center=locpt;
	View_sottotime.transform=  CGAffineTransformMakeScale(1.0, 0.7);
	View_sottotime.hidden=YES;
	
	
	UIFont *TimeFont = [UIFont fontWithName:@"Arial" size:18];
	Label_Time = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 300.0, 60.0)];
	Label_Time.textColor = [UIColor blackColor];
	Label_Time.backgroundColor = [UIColor clearColor];
	Label_Time.textAlignment = UITextAlignmentCenter;	
	[View_sfondo addSubview: Label_Time];	
	Label_Time.hidden=YES;
	Label_Time.text=@"0:00"; 
	Label_Time.font=TimeFont;
	locpt.x=240;	locpt.y=20;  	Label_Time.center=locpt;
	
	
	img_title15     = [UIImage imageNamed:@"i15title.png"];	
	img_titlejp     = [UIImage imageNamed:@"jptitle.png"];
	View_title15    = [[UIImageView alloc] initWithImage: img_title15   ]; 
	View_titlejp    = [[UIImageView alloc] initWithImage: img_titlejp   ]; 
    [View_sfondo addSubview: View_title15];
    [View_sfondo addSubview: View_titlejp];
	locpt.x=130; locpt.y=50;
	View_title15.center=locpt;
	locpt.x=340; locpt.y=50;
	View_titlejp.center=locpt;
	
	img_panel     = [UIImage imageNamed:@"panel.png"];	
	View_panel    = [[UIImageView alloc] initWithImage: img_panel ]; 
	locpt.x=240; locpt.y=160;
	View_panel.center=locpt;
	View_panel.hidden=YES;
	[Pagina3 addSubview: View_panel];	
    [View_panel addSubview: View_backpanel];
	locpt.x=img_panel.size.width-40; locpt.y=img_panel.size.height-40;
	View_backpanel.center=locpt;
	
	View_title15record    = [[UIImageView alloc] initWithImage: img_title15   ]; 
	View_titlejprecord    = [[UIImageView alloc] initWithImage: img_titlejp   ]; 
    [View_panel addSubview: View_title15record];
    [View_panel addSubview: View_titlejprecord];
	View_title15record.transform=  CGAffineTransformMakeScale(0.6, 0.6);
	View_titlejprecord.transform=  CGAffineTransformMakeScale(0.6, 0.6);
	
	locpt.x=120; locpt.y=50;
	View_title15record.center=locpt;
	locpt.x=300; locpt.y=50;
	View_titlejprecord.center=locpt;
	View_title15record.hidden=YES;
	View_titlejprecord.hidden=YES;
    [self loadlabelrecords];
	
	img_solution15  = [UIImage imageNamed:@"solution15.png"];
	img_solutionjp = [UIImage imageNamed:@"solutionjp.png"];
	View_solution15 = [[UIImageView alloc] initWithImage: img_solution15  ]; 
	View_solutionjp = [[UIImageView alloc] initWithImage: img_solutionjp  ]; 
	
	[View_panel addSubview: View_solution15];
	[View_panel addSubview: View_solutionjp];
	
	View_solution15.transform=  CGAffineTransformMakeScale(0.6, 0.6);
	View_solutionjp.transform=  CGAffineTransformMakeScale(0.6, 0.6);
	locpt.x=img_panel.size.width/2; locpt.y=img_panel.size.height/2+20;
	View_solution15.center=locpt;
	locpt.x=img_panel.size.width/2; locpt.y=img_panel.size.height/2+30;
	View_solutionjp.center=locpt;
	View_solution15.hidden=YES;
	View_solutionjp.hidden=YES;
	
	
	UIFont *RulesFont = [UIFont fontWithName:@"Arial" size:24];
	
	for(int i=0; i<6   ;i++)  {
		Label_rules[i] = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 400.0, 60.0)];
		Label_rules[i].textColor = [UIColor blackColor];
		Label_rules[i].backgroundColor = [UIColor clearColor];
		Label_rules[i].textAlignment = UITextAlignmentCenter;	
		[View_panel addSubview: Label_rules[i]];	
		Label_rules[i].hidden=YES;
		Label_rules[i].font=RulesFont;
		locpt.x=240;	locpt.y=20*i;  	Label_rules[i].center=locpt;
	}
	
	for (int i=0; i<3   ;i++)  { Label_rules[i].textColor = [UIColor whiteColor];   };
	
	Label_rules[0].text=@"Make this Goal Position:"; 
	locpt.x=img_panel.size.width/2; locpt.y=60;
  	Label_rules[0].center=locpt;
	Label_rules[1].text=@"Put the Big Square"; 
	locpt.x=img_panel.size.width/2; locpt.y=45;  	Label_rules[1].center=locpt;
	Label_rules[2].text=@"at Extreme Left as the Picture"; 
	locpt.x=img_panel.size.width/2; locpt.y=75;  	Label_rules[2].center=locpt;
	
	Label_rules[3].text=@"Make this Goal Position:"; 
	locpt.x=img_panel.size.width/2-1; locpt.y=60; 	Label_rules[3].center=locpt;      	            
	Label_rules[4].text=@"Put the Big Square"; 
	locpt.x=img_panel.size.width/2-1; locpt.y=45;  	Label_rules[4].center=locpt;
	Label_rules[5].text=@"at Extreme Left as the Picture"; 
	locpt.x=img_panel.size.width/2-1; locpt.y=75;  	Label_rules[5].center=locpt;
	
	
	
	
	// gioco del 15
	img_base15            = [UIImage imageNamed:@"base15.png"];	
	img_scheda15          = [UIImage imageNamed:@"but15.png"];
	img_scheda15h         = [UIImage imageNamed:@"but15h.png"];
	
	dimxscheda15  = img_scheda15.size.width;
	dimyscheda15  = img_scheda15.size.height;
	
	View_supporto15 = [[UIImageView alloc] initWithImage: img_base15];	View_supporto15.image=nil;
	[Pagina1 addSubview: View_supporto15];	
	
	View_base15  = [[UIImageView alloc] initWithImage: img_base15]; 
	[View_supporto15 addSubview:View_base15 ];	    View_base15.alpha=0.80;
	
	locpt.x=130;     locpt.y=174;
	View_supporto15.center=locpt;
	View_supporto15.transform=  CGAffineTransformMakeScale(f_scale15, f_scale15);
	
	for(int i=0; i<15   ;i++)  {
		View_scheda15[i]   = [[UIImageView alloc] initWithImage: img_scheda15   highlightedImage: img_scheda15h ]; 
		[View_supporto15 addSubview:View_scheda15[i] ];	  
		locpt.x=[self dimmiposxscheda:i];
		locpt.y=[self dimmiposyscheda:i];
		View_scheda15[i].center=locpt;
	}
	
	View_overscheda15[0] = [[UIImageView alloc] initWithImage: img_digits[1] ];	
	View_overscheda15[1] = [[UIImageView alloc] initWithImage: img_digits[2] ];	
	View_overscheda15[2] = [[UIImageView alloc] initWithImage: img_digits[3] ];	
	View_overscheda15[3] = [[UIImageView alloc] initWithImage: img_digits[4] ];	
	View_overscheda15[4] = [[UIImageView alloc] initWithImage: img_digits[5] ];	
	View_overscheda15[5] = [[UIImageView alloc] initWithImage: img_digits[6] ];	
	View_overscheda15[6] = [[UIImageView alloc] initWithImage: img_digits[7] ];	
	View_overscheda15[7] = [[UIImageView alloc] initWithImage: img_digits[8] ];	
	View_overscheda15[8] = [[UIImageView alloc] initWithImage: img_digits[9] ];	
	
	View_overscheda15[9]  = [[UIImageView alloc] initWithImage: img_digits[1] ];	
	View_overscheda15[10] = [[UIImageView alloc] initWithImage: img_digits[1] ];	
	View_overscheda15[11] = [[UIImageView alloc] initWithImage: img_digits[1] ];	
	View_overscheda15[12] = [[UIImageView alloc] initWithImage: img_digits[1] ];	
	View_overscheda15[13] = [[UIImageView alloc] initWithImage: img_digits[1] ];	
	View_overscheda15[14] = [[UIImageView alloc] initWithImage: img_digits[1] ];	
	
	View_overscheda15b[0] = [[UIImageView alloc] initWithImage: img_digits[0] ];	
	View_overscheda15b[1] = [[UIImageView alloc] initWithImage: img_digits[1] ];	
	View_overscheda15b[2] = [[UIImageView alloc] initWithImage: img_digits[2] ];	
	View_overscheda15b[3] = [[UIImageView alloc] initWithImage: img_digits[3] ];	
	View_overscheda15b[4] = [[UIImageView alloc] initWithImage: img_digits[4] ];	
	View_overscheda15b[5] = [[UIImageView alloc] initWithImage: img_digits[5] ];	
	
	
	locpt.x=dimxscheda15/2;     locpt.y=dimyscheda15/2;
	
	for(int i=0; i<9   ;i++)  {		
		[View_scheda15[i] addSubview:View_overscheda15[i] ];
		View_overscheda15[i].center=locpt;
		View_overscheda15[i].transform=  CGAffineTransformMakeScale(0.7, 0.7);
	}	
	
	locpt.x=dimxscheda15/2-10; 
	for(int i=9; i<15   ;i++)  {		
		[View_scheda15[i] addSubview:View_overscheda15[i] ];
		View_overscheda15[i].center=locpt;
		View_overscheda15[i].transform=  CGAffineTransformMakeScale(0.6, 0.7);
	}	
	
	locpt.x=dimxscheda15/2+10; 
	for(int i=0; i<6   ;i++)  {		
		[View_scheda15[i+9] addSubview:View_overscheda15b[i] ];
		View_overscheda15b[i].center=locpt;
		View_overscheda15b[i].transform=  CGAffineTransformMakeScale(0.6, 0.7);
	}	
	
	
	
	UIFont *TitleFont    = [UIFont fontWithName:@"Arial" size:32];
	
	// panelInfo
	for(int i=0; i<5   ;i++)  {
		Label_info[i] = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 400.0, 60.0)];
		Label_info[i].textColor = [UIColor blackColor];
		Label_info[i].backgroundColor = [UIColor clearColor];
		Label_info[i].textAlignment = UITextAlignmentCenter;	
		[View_panel addSubview: Label_info[i]];	
		Label_info[i].hidden=YES;
	}
	Label_info[0].text=@"Info";             	     locpt.x=img_panel.size.width/2;	locpt.y=50;   Label_info[0].center=locpt;
	Label_info[0].font=TitleFont;
	Label_info[1].text=@"(c)   2010  Carlo Macor";	 locpt.x=img_panel.size.width/2;	locpt.y=230;   Label_info[1].center=locpt;
	Label_info[2].text=@"Other Games";
	locpt.x=img_panel.size.width/2;	locpt.y=110;   Label_info[2].center=locpt;
	Label_info[3].text=@"contact :";
	locpt.x=img_panel.size.width/2;	locpt.y=160;   Label_info[3].center=locpt;
	Label_info[4].text=@"carlomacor@carlomacor.com";
	locpt.x=img_panel.size.width/2;	locpt.y=180;   Label_info[4].center=locpt;
	
	
	
	CGRect frame = CGRectMake(40.0, 12.0, 160.0, 90);
	frame.origin.x=198.0;   frame.origin.y=12.0;
	frame.size.width=160.0;	frame.size.height=40.0;
	OtherGamesButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	OtherGamesButton.frame = frame;
	[OtherGamesButton setTitle:@"Other Games" forState:UIControlStateNormal];
	OtherGamesButton.backgroundColor = [UIColor clearColor];
	[OtherGamesButton addTarget:self action:@selector(buttonaction:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview: OtherGamesButton];	
	locpt.x=240;	    locpt.y=125;  
	OtherGamesButton.center=locpt;
	OtherGamesButton.hidden=YES;
	
}			// base piu il 15  panelinfo


- (void) scambial15con : (int) ind {
	int oldx1; int oldy1;
	oldx1=pos15x[15];	  oldy1=pos15y[15];
	pos15x[15]=pos15x[ind];	  pos15y[15]=pos15y[ind];
	pos15x[ind]=oldx1;	      pos15y[ind]=oldy1;
}


- (int) dimmischeda15dir: (int) ind {
	int locres=0;   int x1; int y1;
	x1=pos15x[15];	y1=pos15y[15];
	if (ind==0) y1--;	if (ind==1) x1++;
	if (ind==2) y1++;	if (ind==3) x1--;
    for(int i=0; i<15   ;i++)  { if ( (pos15x[i]==x1) &	(pos15y[i]==y1) ) locres=i;	}
	return locres;
}


- (void) posizioneiniziale15                         {
	CGPoint locpt; 
	int c1; int c2;  
	
	pos15x[0] =0;	pos15y[0] =0;
	pos15x[1] =1;	pos15y[1] =0;
	pos15x[2] =2;	pos15y[2] =0;
	pos15x[3] =3;	pos15y[3] =0;
	
	pos15x[4] =0;	pos15y[4] =1;
	pos15x[5] =1;	pos15y[5] =1;
	pos15x[6] =2;	pos15y[6] =1;
	pos15x[7] =3;	pos15y[7] =1;
	
	pos15x[8] =0;	pos15y[8] =2;
	pos15x[9] =1;	pos15y[9] =2;
	pos15x[10]=2;	pos15y[10]=2;
	pos15x[11]=3;	pos15y[11]=2;
	
	pos15x[12]=0;	pos15y[12]=3;
	pos15x[13]=1;	pos15y[13]=3;
	pos15x[14]=2;	pos15y[14]=3;
	pos15x[15]=3;	pos15y[15]=3;
	
	i_timegioco15=0;
	b_usedrecord15=NO;
	
	srandomdev();
	div_t locvalue; 
	
	for(int i=0; i<700   ;i++)  { 
		locvalue = div(random() ,4);  c1= locvalue.rem;
		switch (c1) { 
			case 0 :  if (pos15y[15]>0) {  c2=[self dimmischeda15dir:0];  [self scambial15con:c2]; }	 break;
			case 1 :  if (pos15x[15]<3) {  c2=[self dimmischeda15dir:1];  [self scambial15con:c2]; }	 break;
			case 2 :  if (pos15y[15]<3) {  c2=[self dimmischeda15dir:2];  [self scambial15con:c2]; }	 break;
			case 3 :  if (pos15x[15]>0) {  c2=[self dimmischeda15dir:3];  [self scambial15con:c2]; }	 break;
		}
	}
	
	
	
	for(int i=0; i<15   ;i++)  { 
		locpt.x=[self dimmiposxscheda:i];
		locpt.y=[self dimmiposyscheda:i];
		View_scheda15[i].center=locpt;
		View_scheda15[i].highlighted=NO;
	}
	
	b_gameOver15=NO;
}       // Init posizione 15

- (void) posizioneinizialejp                         {
	CGPoint locpt; 
	posjpx[0] =3;	posjpy[0] =1;
	posjpx[1] =1;	posjpy[1] =0;
	posjpx[2] =3;	posjpy[2] =0;
	posjpx[3] =1;	posjpy[3] =3;
	posjpx[4] =3;	posjpy[4] =3;
	posjpx[5] =1;	posjpy[5] =1;
	posjpx[6] =0;	posjpy[6] =0;
	posjpx[7] =0;	posjpy[7] =1; 
	posjpx[8] =0;	posjpy[8] =2; 
	posjpx[9] =0;	posjpy[9] =3;
	
	posjpx[10] =2;	posjpy[10] =1;  // le vuote
	posjpx[11] =2;	posjpy[11] =2;
	
	//  iniziale risolto
	/*	
	 posjpx[0] =1;	posjpy[0] =1;
	 posjpx[1] =1;	posjpy[1] =0;
	 posjpx[2] =3;	posjpy[2] =0;
	 posjpx[3] =1;	posjpy[3] =3;
	 posjpx[4] =3;	posjpy[4] =3;
	 posjpx[5] =3;	posjpy[5] =1;
	 posjpx[6] =0;	posjpy[6] =0;
	 posjpx[7] =4;	posjpy[7] =1; 
	 posjpx[8] =4;	posjpy[8] =2; 
	 posjpx[9] =0;	posjpy[9] =3;
	 
	 posjpx[10] =0;	posjpy[10] =1;  // le vuote
	 posjpx[11] =0;	posjpy[11] =2;
	 */  
	// iniziale risolto	
	
	
	
	for(int i=0; i<12   ;i++)  { 
		locpt.x=[self dimmiposxschedajp:i];
		locpt.y=[self dimmiposyschedajp:i];
		View_schedajp[i].center=locpt;	
		View_schedajp[i].highlighted=NO;
	}
	
	View_schedajp[10].alpha=0.5;
	View_schedajp[11].alpha=0.5;
	i_timegiocojp=0;
	b_usedrecordjp=NO;
	i_contamossedemojp=0;
	b_gameOverjp=NO;
	
	i_contamossejp=110;
}



- (void) p_StartNewGame                              {
	
	View_back.hidden=NO;  View_sound.hidden=NO;
	if (f_soundlevel>0)  View_sound.highlighted=NO; else View_sound.highlighted=YES;
	
	View_sottotime.hidden=NO;
	Label_Time.hidden=NO;
	if (b_infase15) {[self posizioneiniziale15 ];  View_supporto15.alpha=1.0; self.gameState= kstate_inGame15; View_sottotime.highlighted=NO; } 
	           else {[self posizioneinizialejp ];  View_supportojp.alpha=1.0; self.gameState= kstate_inGamejp; View_sottotime.highlighted=YES; 
				   labdemojp.hidden=NO;	labcontamosse.hidden=NO;	comprafinale.hidden=NO;
			   }
}			// in Gioco

- (void) p_StartContinue                             {
	View_back.hidden=NO;	View_sound.hidden=NO;
	if (f_soundlevel>0)  View_sound.highlighted=NO; else View_sound.highlighted=YES;
	
	View_sottotime.hidden=NO;
	Label_Time.hidden=NO;
	if (b_infase15) { if ([self b_serisolto15]) [self posizioneiniziale15]; } 
	           else { [self posizioneinizialejp]; }  // in demo riparti sempre
	
	if (b_infase15) { View_supporto15.alpha=1.0; self.gameState= kstate_inGame15; View_sottotime.highlighted=NO;} 
	           else { View_supportojp.alpha=1.0; self.gameState= kstate_inGamejp; View_sottotime.highlighted=YES;
			   
				   labdemojp.hidden=NO;	labcontamosse.hidden=NO;	comprafinale.hidden=NO;

			   }
	
	View_supportojp.transform=  CGAffineTransformMakeScale(1.1, 1.1);
	
	
	
}


- (void) buttonaction                :(id)sender     {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.com/apps/jaypag"]];
	//	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.carlomacor.com"]];
	
}        /// APPSTORE

- (void) mettilabelmenu                              {
	CGPoint locpt; 
	locpt.x=i_dimx2opzmenu;  	locpt.y=i_dimy2opzmenu;
	
	for (int i=0; i<NUMLABELMENU; i++) { 
		labMenu15[i] = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120.0, 20.0)];
		labMenu15[i].textColor = [UIColor whiteColor];
		labMenu15[i].backgroundColor = [UIColor clearColor];
		labMenu15[i].textAlignment = UITextAlignmentCenter;	
		labMenu15[i].hidden=NO;
		[View_menu15[i] addSubview: labMenu15[i]];	
		labMenu15[i].center=locpt;
	}
	for (int i=0; i<NUMLABELMENU; i++) { 
		labMenujp[i] = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120.0, 20.0)];
		labMenujp[i].textColor = [UIColor whiteColor];
		labMenujp[i].backgroundColor = [UIColor clearColor];
		labMenujp[i].textAlignment = UITextAlignmentCenter;	
		labMenujp[i].hidden=NO;
		[View_menujp[i] addSubview: labMenujp[i]];	
		labMenujp[i].center=locpt;
	}
	
	labMenu15[0].text=@"Continue";	    labMenujp[0].text=@"Continue";
	labMenu15[1].text=@"New game";	    labMenujp[1].text=@"New Game";
	labMenu15[2].text=@"Records";	    labMenujp[2].text=@"Records";
	labMenu15[3].text=@"Rules";	        labMenujp[3].text=@"Rules";
	labMenu15[4].text=@"Jay Pag";	    labMenujp[4].text=@"15";
	labMenu15[5].text=@"Other Games";   labMenujp[5].text=@"Other Games";
	
}

- (void) loadgraficamenu                             {
	img_menu15    = [UIImage imageNamed:@"opz15.png"];		img_menu15h   = [UIImage imageNamed:@"opz15h.png"];	
	img_menujp    = [UIImage imageNamed:@"opzjp.png"];		img_menujph   = [UIImage imageNamed:@"opzjph.png"];	
	for(int i=0; i<NUMLABELMENU   ;i++)  {	
		if (i==4) {
			View_menujp[i] = [[UIImageView alloc] initWithImage: img_menu15  highlightedImage:img_menu15h ];
			View_menu15[i] = [[UIImageView alloc] initWithImage: img_menujp  highlightedImage:img_menujph ];	
		} else 
		{ View_menu15[i] = [[UIImageView alloc] initWithImage: img_menu15  highlightedImage:img_menu15h ];
			View_menujp[i] = [[UIImageView alloc] initWithImage: img_menujp  highlightedImage:img_menujph ];	}
		
		[Pagina3 addSubview: View_menu15[i] ];	
		[Pagina3 addSubview: View_menujp[i] ];	}
	Pagina3.hidden=YES;
	i_dimx2opzmenu   = img_menu15.size.width/2;
	i_dimy2opzmenu   = img_menu15.size.height/2;
	
	[self mettilabelmenu];
}

- (void) p_startOpenMenu             : (int) modo    {
	CGPoint locpt; 
	View_back.hidden=YES;
	View_sound.hidden=YES;
	
    if (modo==0) { 	self.gameState= kstate_openMenu15;		View_supportojp.hidden=YES;   b_infase15=YES;  }   // in 15 
	else {  self.gameState= kstate_openMenujp;		View_supporto15.hidden=YES;   b_infase15=NO;   }   // in jp
	
	if (modo==0) {	for(int i=0; i<NUMLABELMENU   ;i++)  {	View_menu15[i].hidden=NO;	View_menujp[i].hidden=YES;	}}
	else {	for(int i=0; i<NUMLABELMENU   ;i++)  {	View_menu15[i].hidden=YES;	View_menujp[i].hidden=NO;	}}
	
	if (modo==0) { 	self.gameState= kstate_openMenu15;		View_supportojp.hidden=YES; }   // in 15 
	else {  self.gameState= kstate_openMenujp;		View_supporto15.hidden=YES; }   // in jp
	
	//	if (modo==0) { 	View_supporto15.alpha=0.6; }   // in 15 
	//	        else { 	View_supportojp.alpha=0.6; }   // in jp
	
	
	locpt.x=240; locpt.y=-40;
	for(int i=0; i<NUMLABELMENU   ;i++)  {	View_menu15[i].center=locpt;	View_menujp[i].center=locpt;	
		View_menu15[i].highlighted=NO;	View_menujp[i].highlighted=NO;
	}
	Pagina3.hidden=NO;
	
	
	View_title15.hidden=YES;
	View_titlejp.hidden=YES;
	View_sottotime.hidden=YES;
	Label_Time.hidden=YES;
	View_solved.hidden=YES;
	
	labdemojp.hidden=YES;	labcontamosse.hidden=YES;	comprafinale.hidden=YES;

	
}

- (void) p_MenuOpen                                  {  //  kstate_MenuOpen
    CGPoint locpt;      	int  i_velopen=15;
	View_supporto15.alpha=0.30;
	View_supportojp.alpha=0.35;
	
	for (int i=NUMLABELMENU-1; i>=0; i--) { 
		locpt=View_menu15[i].center;   
		if (locpt.y<(i*48+40)) {locpt.y=locpt.y+i_velopen; } else { 
			if (i==(NUMLABELMENU-1))
			{	if (self.gameState == kstate_openMenu15) {self.gameState = kstate_MenuRun15;}
				else {self.gameState = kstate_MenuRunjp;};	}
		}  ;
		if (locpt.y>(i*48+40)) { locpt.y=i*48+40;};
		View_menu15[i].center=locpt;
		View_menujp[i].center=locpt;
	}
}

- (void) p_MenuClose                                 {  //  kstate_menuClose
	CGPoint locpt;	CGPoint locpt2;
	int  i_velclose=20;
	locpt=View_menu15[NUMLABELMENU-1].center;
	locpt.y=locpt.y-i_velclose;
	View_menu15[NUMLABELMENU-1].center=locpt;	View_menujp[NUMLABELMENU-1].center=locpt;
	if (locpt.y<-40){ [self p_EndMenuClose];  } ;
	for (int i=0; i<(NUMLABELMENU-1); i++) { 		
		locpt2=View_menu15[i].center;
		if (locpt.y<locpt2.y) {  View_menu15[i].center=locpt;  View_menujp[i].center=locpt; }  ;
	}
}


- (void) p_EndMenuClose                              {  // <- p_MenuClose
	switch (self.sceltamenu) {
		case 0 :  [self p_StartContinue];              break;  // continue
		case 1 :  [self p_StartNewGame];               break;  // new game
		case 2 :  [self p_StartRecordsOpen];           break;  
		case 3 :  [self p_StarttutorialOpen];          break;  
		case 4 :  self.gameState = kstate_close15jp;             break;  
		case 5 :  [self p_StartInfoOpen];              break;  
		default :	 break;
	}
}           //    qui il case delle opzioni Menu


- (void) p_StartInfoOpen                             {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.com/apps/carlomacor"]];
/*
	View_panel.hidden=NO;
	View_panel.alpha=0.0;
	for(int i=0; i<5   ;i++)  {	Label_info[i].hidden=NO; }
	
	self.gameState=kstate_InfoOpen;
 */
}

- (void) p_InfoOpen                                  {
	View_panel.alpha=View_panel.alpha+0.1;
	if (View_panel.alpha>=1.0) {  View_panel.alpha=1.0;  self.gameState=kstate_Info; 	OtherGamesButton.hidden=NO;  }
}

- (void) p_InfoClose                                 {
	OtherGamesButton.hidden=YES;
	View_panel.alpha=View_panel.alpha-0.1;
	if (View_panel.alpha<=0.0) {  
		for(int i=0; i<5   ;i++)  {	Label_info[i].hidden=YES; }
		View_panel.alpha=0.0;  
		if (b_infase15) { [self p_startOpenMenu:0]; } else { [self p_startOpenMenu:1]; }
		View_panel.hidden=YES; 
	}
}


- (void) p_StartRecordsOpen                          {
	View_panel.hidden=NO;
	View_panel.alpha=0.0;
	View_title15record.hidden=NO;
	View_titlejprecord.hidden=NO;
	[self mettitestorecord];
	self.gameState=kstate_RecordOpen;
}

- (void) p_RecordOpen                                {
	View_panel.alpha=View_panel.alpha+0.1;
	if (View_panel.alpha>=1.0) {  View_panel.alpha=1.0;  self.gameState=kstate_Record;   }
}

- (void) p_RecordClose                               {
	View_panel.alpha=View_panel.alpha-0.1;
	if (View_panel.alpha<=0.0) {  
		for(int i=0; i<10   ;i++)  {Label_records15[i].hidden=YES; Label_recordsjp[i].hidden=YES; }
		View_title15record.hidden=YES;
		View_titlejprecord.hidden=YES;
		View_panel.alpha=0.0;  
		if (b_infase15) { [self p_startOpenMenu:0]; } else { [self p_startOpenMenu:1]; }
		View_panel.hidden=YES; 
	}
}


- (void) p_startSolved                               {
	View_solved.hidden=NO;
	View_solved.alpha=0.0;
	self.gameState=kstate_SolvedOpen;      
	i_contatimesolved15=0;
	i_contatimesolvedjp=0;
	[self Suona2:4];
}

- (void) p_SolvedOpen                                {
	if (b_infase15) {View_supporto15.alpha=View_supporto15.alpha-0.07;  } else {View_supportojp.alpha=View_supportojp.alpha-0.05;  };
	View_solved.alpha=View_solved.alpha+0.1;
	if (View_solved.alpha>=1.0) {  View_solved.alpha=1.0;	self.gameState=kstate_SolvedRun;   }
}

- (void) p_SolvedRun                                 {
	i_contatimesolved15++;
    if (b_infase15) { if ((i_UltimoRecord15<10) & (i_contatimesolved15>30*4)) [self p_StartRecordsOpen];   }
	else 	{ if ((i_UltimoRecordjp<10) & (i_contatimesolved15>30*4)) [self p_StartRecordsOpen];   };
	
	if(i_contatimesolved15>(30*20))
		if (b_infase15) {	[self p_startOpenMenu:0]; } else { [self p_startOpenMenu:1]; };
	
}


- (void) p_StarttutorialOpen                         {
	View_panel.hidden=NO;
	View_panel.alpha=0.0;
	if (b_infase15)  { View_solution15.hidden=NO;  	 Label_rules[0].hidden=NO;   Label_rules[3].hidden=NO; }
	else {View_solutionjp.hidden=NO;    
		Label_rules[1].hidden=NO; Label_rules[2].hidden=NO;
		Label_rules[4].hidden=NO; Label_rules[5].hidden=NO;}
	self.gameState=kstate_TutorialOpen;
}

- (void) p_TutorialOpen                              {
	View_panel.alpha=View_panel.alpha+0.1;
	if (View_panel.alpha>=1.0) {  View_panel.alpha=1.0;  self.gameState=kstate_Tutorial;   }
}

- (void) p_TutorialClose                             {
	View_panel.alpha=View_panel.alpha-0.1;
	if (View_panel.alpha<=0.0) {  
		for(int i=0; i<10   ;i++)  {Label_records15[i].hidden=YES; Label_recordsjp[i].hidden=YES; }
		View_title15record.hidden=YES;
		View_titlejprecord.hidden=YES;
		View_panel.alpha=0.0;  
		if (b_infase15) { [self p_startOpenMenu:0]; } else { [self p_startOpenMenu:1]; }
		View_panel.hidden=YES; 
		View_solution15.hidden=YES;
		View_solutionjp.hidden=YES;
		for(int i=0; i<6   ;i++)  { Label_rules[i].hidden=YES; };
	}
}



- (void) p_open15                                    {
	CGPoint locpt; 
	if (f_scale15<1.1) {f_scale15=f_scale15+0.04;}
	if (f_scale15>1.1) {f_scale15=1.1;}
	View_supporto15.transform=  CGAffineTransformMakeScale(f_scale15, f_scale15);
	locpt=View_supporto15.center;
	if (locpt.x<240) {locpt.x=locpt.x+11;};
	if (locpt.x>240) {locpt.x=240;};
	View_supporto15.center=locpt;
	View_supporto15.alpha=View_supporto15.alpha-0.05;
	if (f_scalejp>0) {f_scalejp=f_scalejp-0.05;}
	if (f_scalejp<0) {f_scalejp=0.0;}
	locpt=View_supportojp.center;
    locpt.x=locpt.x+10;
	View_supportojp.center=locpt;
	View_supportojp.transform=  CGAffineTransformMakeScale(f_scalejp, f_scalejp);
	if (f_scale15>=1.1) { [self p_startOpenMenu:0 ]; }
}

- (void) p_openjp                                    {
	CGPoint locpt; 
	if (f_scalejp<1.1) {f_scalejp=f_scalejp+0.04;}
	if (f_scalejp>1.1) {f_scalejp=1.1;}
	View_supportojp.transform=  CGAffineTransformMakeScale(f_scalejp, f_scalejp);
	locpt=View_supportojp.center;
	if (locpt.x>240) {locpt.x=locpt.x-10;};
	if (locpt.x<240) {locpt.x=240;};
	View_supportojp.center=locpt;
	View_supportojp.alpha=View_supportojp.alpha-0.04;
	
	if (f_scale15>0) {f_scale15=f_scale15-0.05;}
	if (f_scale15<0) {f_scale15=0.0;}
	locpt=View_supporto15.center;
    locpt.x=locpt.x-11;
	View_supporto15.center=locpt;
	View_supporto15.transform=  CGAffineTransformMakeScale(f_scale15, f_scale15);
	if (f_scalejp>=1.1) { [self p_startOpenMenu:1 ];}
}

- (void) p_close15jp                                 {
	CGPoint locpt;  bool closer;
	closer=YES;
	View_supporto15.hidden=NO;
	View_supportojp.hidden=NO;
	View_supporto15.alpha=0.8;
	View_supportojp.alpha=0.8;
	

	
	
	if (b_infase15) {
		if (f_scale15>=0.6) {f_scale15=f_scale15-0.04;}	  if (f_scale15<0.6) {f_scale15=0.6;} else closer=NO;
		locpt=View_supporto15.center;
		if (locpt.x>130) locpt.x=locpt.x-11;       		  if (locpt.x<130) locpt.x=130;
		View_supporto15.center=locpt;
		
		if (f_scalejp<=0.6) {f_scalejp=f_scalejp+0.04;}	  if (f_scalejp>0.6) {f_scalejp=0.6;} else closer=NO;
		locpt=View_supportojp.center;
		if (locpt.x>340) locpt.x=locpt.x-10;       		  if (locpt.x<340) locpt.x=340;
		View_supportojp.center=locpt;		
	} else 	{
		if (f_scale15<=0.6) {f_scale15=f_scale15+0.04;}	  if (f_scale15>0.6) {f_scale15=0.6;} else closer=NO;
		locpt=View_supporto15.center;
		if (locpt.x<130) locpt.x=locpt.x+11;       		  if (locpt.x>130) locpt.x=130;
		View_supporto15.center=locpt;
		
		if (f_scalejp>=0.6) {f_scalejp=f_scalejp-0.04;}	  if (f_scalejp<0.6) {f_scalejp=0.6;} else closer=NO;
		locpt=View_supportojp.center;
		if (locpt.x<340) locpt.x=locpt.x+10;       		  if (locpt.x>340) locpt.x=340;
		View_supportojp.center=locpt;		
	}
	
	
	View_supporto15.transform=  CGAffineTransformMakeScale(f_scale15, f_scale15);
	View_supportojp.transform=  CGAffineTransformMakeScale(f_scalejp, f_scalejp);
	
	if (closer)	{ self.gameState=kstate_run2giochi;  	View_title15.hidden=NO;  	View_titlejp.hidden=NO;}
}


- (int)  TestInsideMenu           : (CGPoint)Ptclick {
	int locres=-1;         	CGPoint locpt; 
	
	if ((Ptclick.x>(240-i_dimx2opzmenu) ) & (Ptclick.x<(240+i_dimx2opzmenu)  )) {
		for (int i=0; i<NUMLABELMENU; i++) { 
			locpt=View_menu15[i].center;   
	        locpt.y=locpt.y+i_dimy2opzmenu;			
			if ((Ptclick.y>(locpt.y-40)) & (Ptclick.y<locpt.y)) {locres=i;  }      	
		}
	}
	for (int i=0; i<NUMLABELMENU; i++) { View_menu15[i].highlighted=NO; View_menujp[i].highlighted=NO;}	 ;
	if (locres>=0) {View_menu15[locres].highlighted=YES; View_menujp[locres].highlighted=YES;}
	
    return locres;
}

- (bool) TestInsidebackmain       : (CGPoint)Ptclick {
	bool res=NO;    	CGPoint locpt;   int  delta=20;
	locpt=View_back.center;
	if ( ((Ptclick.x>(locpt.x-delta)) & (Ptclick.x<(locpt.x+delta)) ) &
		((Ptclick.y>(locpt.y-delta)) & (Ptclick.y<(locpt.y+delta)) ) ) {res=YES; View_back.highlighted=YES; }
	else View_back.highlighted=NO;
	return res;
}

- (bool) TestInsidebackpanel      : (CGPoint)Ptclick {
	bool res=NO;       	CGPoint locpt;   int  delta=20;
	locpt=View_backpanel.center;
	locpt.x=locpt.x+15;	locpt.y=locpt.y+15;
	
	if ( ((Ptclick.x>(locpt.x-delta)) & (Ptclick.x<(locpt.x+delta)) ) &
		((Ptclick.y>(locpt.y-delta)) & (Ptclick.y<(locpt.y+delta)) ) ) {res=YES; View_backpanel.highlighted=YES; }
	else View_backpanel.highlighted=NO;
	return res;
}

- (void) TestUPInsidebackpanel    : (CGPoint)Ptclick {
	if ([self TestInsidebackpanel:Ptclick])   { View_backpanel.highlighted=NO; 
		if (self.gameState==kstate_Info)     self.gameState=kstate_InfoClose; 
		if (self.gameState==kstate_Record)   self.gameState=kstate_RecordClose; 
		if (self.gameState==kstate_Tutorial) self.gameState=kstate_TutorialClose; 
		
		
	} ;
} 

- (bool) TestInsidesound          : (CGPoint)Ptclick {
	bool res=NO;    	CGPoint locpt;   int  delta=20;
	locpt=View_sound.center;
	if ( ((Ptclick.x>(locpt.x-delta)) & (Ptclick.x<(locpt.x+delta)) ) &
		((Ptclick.y>(locpt.y-delta)) & (Ptclick.y<(locpt.y+delta)) ) ) {res=YES; View_sound.highlighted=!View_sound.highlighted; }
	if (res) {
		if (View_sound.highlighted)  {f_soundlevel=0.0;} else {f_soundlevel=50.0;}
		[self settavolumi];
	}
	return res;
}

- (bool) b_serisolto15                               {
	bool locres=NO;    int testo;
	testo=0;
	for (int i=0; i<16; i++) {
		if (posfinale15x[i]==pos15x[i]) { 	testo++;   }
		if (posfinale15y[i]==pos15y[i]) {   testo++;   }
	}
	if (testo>=32) locres=YES; 
	return locres;
}


- (void) testrisolto15                               {
	if ([self b_serisolto15]) 
	{[self mettirecords]; 
		b_gameOver15=YES;
		[self p_startSolved];
	}
}

- (bool) b_serisoltojp                               {
	bool locres=NO;
	if ( (posjpx[0]==0) & (posjpy[0]==1) ) locres=YES;
	return locres;
}


- (void) testrisoltojp                               {
	if ([self b_serisoltojp]) 	{[self mettirecords]; 		b_gameOverjp=YES;		[self p_startSolved];	}	
}



- (void) clickupMenu15            : (CGPoint)Ptclick {
	int res;
	res = [self TestInsideMenu : Ptclick];
	if (res>=0) {sceltamenu=res;   self.gameState=kstate_closemenu; }
	
}

- (void) clickupMenujp            : (CGPoint)Ptclick {
	int res;
	res = [self TestInsideMenu : Ptclick];
	if (res>=0) {sceltamenu=res;   self.gameState=kstate_closemenu; }
}

- (void) clickup2giochi           : (CGPoint)Ptclick {	
	CGPoint locpt; int  deltax=20;   int  deltay=20;
	locpt =View_supporto15.center;
	deltax=(img_base15.size.width/2)*0.6;
	deltay=(img_base15.size.height/2)*0.6;
	if ( ((Ptclick.x>(locpt.x-deltax)) & (Ptclick.x<(locpt.x+deltax)) ) &
		((Ptclick.y>(locpt.y-deltay)) & (Ptclick.y<(locpt.y+deltay)) ) ) {
		self.gameState=kstate_open15;
		View_title15.hidden=YES;	View_titlejp.hidden=YES;    }
	
	locpt =View_supportojp.center;
	deltax=(img_basejp.size.width/2)*0.6;
	deltay=(img_basejp.size.height/2)*0.6;
	if ( ((Ptclick.x>(locpt.x-deltax)) & (Ptclick.x<(locpt.x+deltax)) ) &
		((Ptclick.y>(locpt.y-deltay)) & (Ptclick.y<(locpt.y+deltay)) ) ){self.gameState=kstate_openjp;
		View_title15.hidden=YES;	View_titlejp.hidden=YES;    }
	
}   // click in fase due giochi iniziale


- (int)  TestInsidepedina15       : (CGPoint)Ptclick {
	CGPoint locpt; 
	CGPoint clickpt;	CGPoint clickptext; CGPoint centext;  int dxext; int dyext;
    // estensione rapporto 1.1
	clickptext=Ptclick;
	centext=View_supporto15.center;
	dxext=clickptext.x-centext.x;	dxext=dxext/1.1;
	dyext=clickptext.y-centext.y;	dyext=dyext/1.1;
	Ptclick.x=centext.x+dxext;
	Ptclick.y=centext.y+dyext;
	
	clickpt=Ptclick;
	clickpt.x=clickpt.x-(centext.x-img_base15.size.width/2);
	clickpt.y=clickpt.y-(centext.y-img_base15.size.height/2);
	int locres=-1;   int oldpedina;
	oldpedina=i_pedina15;
	for(int i=0; i<15   ;i++)  {
		locpt.x=[self dimmiposxscheda:i];
		locpt.y=[self dimmiposyscheda:i];
		if  ( ( (clickpt.x>(locpt.x-dimxscheda15/2)) & (clickpt.x<(locpt.x+dimxscheda15/2)) ) 
			 & ( (clickpt.y>(locpt.y-dimxscheda15/2)) & (clickpt.y<(locpt.y+dimxscheda15/2)) ) )
		{ i_pedina15=i; locres=i;   }
	}
	for(int i=0; i<15   ;i++)  {  View_scheda15[i].highlighted=NO; }
	if (locres>=0) View_scheda15[i_pedina15].highlighted=YES;
	if (locres<0) i_pedina15=-1;
    return locres;
}

- (bool) TestInsidepedina15vuota  : (CGPoint)Ptclick {
	bool locres; bool spostax=NO; bool spostay=NO;   int oldpedina;
	locres=NO;
	CGPoint oldcenter; 
	CGPoint center1; 	CGPoint center2; 
	oldpedina=i_pedina15;
	[self TestInsidepedina15:Ptclick ];
	if (oldpedina!=i_pedina15) { 
		if (i_pedina15<0) { i_pedina15=oldpedina; } else  
		{ b_clicked=YES;    click_x=Ptclick.x;     click_y=Ptclick.y;  [self riposizionatutte15];  return locres;  }     
	}
	
	if (!b_clicked) return locres;
	if ( i_pedina15<0) return locres;
	int dx; int dy;  int i_offx; int i_offy;
	
	i_offx=pos15x[15]-pos15x[i_pedina15]; 
	i_offy=pos15y[15]-pos15y[i_pedina15]; 
	
	dx=Ptclick.x-click_x;	dy=Ptclick.y-click_y;
	if ((dx>0) & (i_offx== 1) & (i_offy==0)  ) { spostax=YES;	}
	if ((dx<0) & (i_offx==-1) & (i_offy==0)  ) { spostax=YES;	}
	
	if ((dy>0) & (i_offy== 1) & (i_offx==0)  ) { spostay=YES;	}
	if ((dy<0) & (i_offy==-1) & (i_offx==0)  ) { spostay=YES;	}
	
	
	int olddx; int olddy;
	CGPoint olddd; 
	olddd=View_scheda15[i_pedina15].center;	    	
	olddx=-([self dimmiposxscheda:i_pedina15]-olddd.x);
	olddy=-([self dimmiposyscheda:i_pedina15]-olddd.y);
	if (olddx!=0) spostay=NO;
	if (olddy!=0) spostax=NO;
	
	if ((olddx>0) & (dx<0) & ((olddx+dx)>=0)) { spostax=YES;}
	if ((olddx>0) & (dx<0) & ((olddx+dx)<0))  { dx=-olddx;   spostax=YES;}
	
	if ((olddx<0) & (dx>0) & ((olddx+dx)<=0)) spostax=YES;
	if ((olddx<0) & (dx>0) & ((olddx+dx)>0))  { dx=-olddx;   spostax=YES;}
	
	if ((olddy>0) & (dy<0) & ((olddy+dy)>=0)) spostay=YES;
	if ((olddy>0) & (dy<0) & ((olddy+dy)<0))  { dy=-olddy;   spostay=YES;}
	
	
	if ((olddy<0) & (dy>0) & ((olddy+dy)<=0)) spostay=YES;
	if ((olddy<0) & (dy>0) & ((olddy+dy)>0))  { dy=-olddy;   spostay=YES;}
	
	
	
	if (spostax) {	oldcenter=View_scheda15[i_pedina15].center;	    oldcenter.x=oldcenter.x+dx;
		click_x=click_x+dx;  	View_scheda15[i_pedina15].center=oldcenter;	}
	
	if (spostay) {	oldcenter=View_scheda15[i_pedina15].center;		oldcenter.y=oldcenter.y+dy;
		click_y=click_y+dy;		View_scheda15[i_pedina15].center=oldcenter;	}
	
	
	
	center1=View_scheda15[i_pedina15].center;	
	center2.x=[self dimmiposxscheda:i_pedina15];
	center2.y=[self dimmiposyscheda:i_pedina15];
	dx=center1.x-center2.x;	
	dy=center1.y-center2.y;
    if (dx<0) {dx=-dx;};    if (dy<0) {dy=-dy;};
	if (dx>(dimxscheda15/2)) { 	locres=YES;   }
	if (dy>(dimyscheda15/2)) { 	locres=YES;   }
	
	return locres;
}

- (void) riposizionatutte15                          {
	CGPoint locpt;
	for(int i=0; i<15   ;i++)  {
		locpt.x=[self dimmiposxscheda:i];
		locpt.y=[self dimmiposyscheda:i];
		View_scheda15[i].center=locpt;			
		//	  View_scheda15[i].highlighted=NO;
	}
}

- (void) cambia15                 : (int) ind        {
	int oldmodxped;	int oldmodyped;  CGPoint locpt; 
	int dx; int dy;
	dx=pos15x[i_pedina15]-pos15x[15]; if (dx<0) dx=-dx;
	dy=pos15y[i_pedina15]-pos15y[15]; if (dy<0) dy=-dy;
	dx=dx+dy;
	if (dx>1) return; 
	oldmodxped=pos15x[i_pedina15];	oldmodyped=pos15y[i_pedina15];
    pos15x[i_pedina15]=pos15x[15];	pos15y[i_pedina15]=pos15y[15];
	pos15x[15]=oldmodxped;    	    pos15y[15]=oldmodyped;
	locpt.x=[self dimmiposxscheda:i_pedina15];
	locpt.y=[self dimmiposyscheda:i_pedina15];
	View_scheda15[i_pedina15].center=locpt;	
	[self riposizionatutte15 ];
	//	b_clicked=NO;	i_pedina15=-1;
	[self testrisolto15];
}

- (void) i15_ClickUp              : (CGPoint)Ptclick {
	if ([self TestInsidebackmain:Ptclick])   { [self p_startOpenMenu:0]; View_back.highlighted=NO;    }  ;
	//	if ([self TestInsidepedina15:Ptclick]>=0) 	
	for(int i=0; i<15   ;i++)  {  View_scheda15[i].highlighted=NO; }
	// riposizionale tutte al centro 
	[self riposizionatutte15 ];
	b_clicked=NO;
}   // Gioco del 15

- (void) i15_Clickdown            : (CGPoint)Ptclick {
	[self TestInsidebackmain:Ptclick];	
	[self TestInsidesound   :Ptclick];
	if ([self TestInsidepedina15:Ptclick]>=0) 	{    click_x=Ptclick.x;   click_y=Ptclick.y;  b_clicked=YES; } ;
}   

- (void) i15_ClickMove            : (CGPoint)Ptclick {
	[self TestInsidebackmain:Ptclick]; 
	if ([self TestInsidepedina15vuota:Ptclick])  { if (i_pedina15>=0) { [self cambia15:i_pedina15];  [self Suona2:0];   }   }
	//	[self TestInsidepedina15:Ptclick];
} 



- (int) TestInsidepedinajp        : (CGPoint)Ptclick {
	CGPoint locpt; 	  CGPoint clickpt; 
	
	CGPoint clickptext; CGPoint centext;  int dxext; int dyext;
    // estensione rapporto 1.1
	clickptext=Ptclick;
	centext=View_supportojp.center;
	dxext=clickptext.x-centext.x;	dxext=dxext/1.1;
	dyext=clickptext.y-centext.y;	dyext=dyext/1.1;
	Ptclick.x=centext.x+dxext;
	Ptclick.y=centext.y+dyext;
	
	
	
	
	clickpt=Ptclick;
	clickpt.x=clickpt.x-(centext.x-img_basejp.size.width/2);
	clickpt.y=clickpt.y-(centext.y-img_basejp.size.height/2);
	int locres=-1;   int oldpedina;
	oldpedina=i_pedinajp;
	
	locpt.x=[self dimmiposxschedajp:0]; 	locpt.y=[self dimmiposyschedajp:0];
	if  ( ( (clickpt.x>=(locpt.x-img_schedajp[0].size.width/2)) & (clickpt.x<(locpt.x+img_schedajp[0].size.width/2)) ) 
		 & ( (clickpt.y>=(locpt.y-img_schedajp[0].size.height/2)) & (clickpt.y<(locpt.y+img_schedajp[0].size.height/2)) ) )
	{ locres=0; }
	
	for(int i=1; i<5   ;i++)  { 
		locpt.x=[self dimmiposxschedajp:i]; 	locpt.y=[self dimmiposyschedajp:i];
		if  ( ( (clickpt.x>=(locpt.x-img_schedajp[1].size.width/2)) & (clickpt.x<(locpt.x+img_schedajp[1].size.width/2)) ) 
			 & ( (clickpt.y>=(locpt.y-img_schedajp[1].size.height/2)) & (clickpt.y<(locpt.y+img_schedajp[1].size.height/2)) ) )
		{ locres=i; }
	}
	
	locpt.x=[self dimmiposxschedajp:5]; 	locpt.y=[self dimmiposyschedajp:5];
	if  ( ( (clickpt.x>=(locpt.x-img_schedajp[2].size.width/2)) & (clickpt.x<(locpt.x+img_schedajp[2].size.width/2)) ) 
		 & ( (clickpt.y>=(locpt.y-img_schedajp[2].size.height/2)) & (clickpt.y<(locpt.y+img_schedajp[2].size.height/2)) ) )
	{ locres=5; }
	
	for(int i=6; i<10   ;i++)  { 
		locpt.x=[self dimmiposxschedajp:i]; 	locpt.y=[self dimmiposyschedajp:i];
		if  ( ( (clickpt.x>=(locpt.x-img_schedajp[3].size.width/2)) & (clickpt.x<(locpt.x+img_schedajp[3].size.width/2)) ) 
			 & ( (clickpt.y>=(locpt.y-img_schedajp[3].size.height/2)) & (clickpt.y<(locpt.y+img_schedajp[3].size.height/2)) ) )
		{ locres=i; }
	}
	
	
	for(int i=0; i<15   ;i++)  {  View_schedajp[i].highlighted=NO; }
	if (locres>=0) View_schedajp[locres].highlighted=YES;
	i_pedinajp=locres;
    return locres;
}

- (int) TestInsidepedinajpvuota   : (CGPoint)Ptclick {
	int locres; bool spostax=NO; bool spostay=NO;  int risulto;   int oldpedina;
	int locreslocal;
	CGPoint oldcenter; 
	CGPoint center1; 	CGPoint center2; 
	int dx; int dy;  int i_offx1; int i_offy1; 
	int i_offx2; int i_offy2;
    int olddx; int olddy;
	CGPoint olddd; 
	locres=-1;
	
	oldpedina=i_pedinajp;
	[self TestInsidepedinajp:Ptclick ];
	if (oldpedina!=i_pedinajp) { 
		if (i_pedinajp<0) { i_pedinajp=oldpedina; } else  
		{ b_clicked=YES;    click_x=Ptclick.x;     click_y=Ptclick.y;  [self riposizionatuttejp];  return locres;  }     
	}
	
	
	
	if (!b_clicked)    return locres;
	if ( i_pedinajp<0) return locres;
	
	dx=Ptclick.x-click_x;	dy=Ptclick.y-click_y;
	
	i_offx1=posjpx[10]-posjpx[i_pedinajp]; 	i_offx2=posjpx[11]-posjpx[i_pedinajp]; 
	i_offy1=posjpy[10]-posjpy[i_pedinajp];	i_offy2=posjpy[11]-posjpy[i_pedinajp];
	
	if (dx<0){ risulto=[self testmovejp:1]; if (risulto>=0) {spostax=YES;  locreslocal=risulto; 			   } };
	if (dx>0){ risulto=[self testmovejp:3]; if (risulto>=0) {spostax=YES;  locreslocal=risulto; 			   } };
	if (dy>0){ risulto=[self testmovejp:2]; if (risulto>=0) {spostay=YES;  locreslocal=risulto; 			   } };
	if (dy<0){ risulto=[self testmovejp:4]; if (risulto>=0) {spostay=YES;  locreslocal=risulto; 			   } };
	
	olddd=View_schedajp[i_pedinajp].center;	    	
	olddx=-([self dimmiposxschedajp:i_pedinajp]-olddd.x);
	olddy=-([self dimmiposyschedajp:i_pedinajp]-olddd.y);
	if (olddx!=0) spostay=NO;
	if (olddy!=0) spostax=NO;
	
	
	
	if ((olddx>0) & (dx<0) & ((olddx+dx)>=0)) { spostax=YES;}
	if ((olddx>0) & (dx<0) & ((olddx+dx)<0))  { dx=-olddx;   spostax=YES;}
	
	if ((olddx<0) & (dx>0) & ((olddx+dx)<=0)) spostax=YES;
	if ((olddx<0) & (dx>0) & ((olddx+dx)>0))  { dx=-olddx;   spostax=YES;}
	
	if ((olddy>0) & (dy<0) & ((olddy+dy)>=0)) spostay=YES;
	if ((olddy>0) & (dy<0) & ((olddy+dy)<0))  { dy=-olddy;   spostay=YES;}
	
	
	if ((olddy<0) & (dy>0) & ((olddy+dy)<=0)) spostay=YES;
	if ((olddy<0) & (dy>0) & ((olddy+dy)>0))  { dy=-olddy;   spostay=YES;}
	
	if (spostax) spostay=NO;
	
	if (spostax) {	
		oldcenter=View_schedajp[i_pedinajp].center;	    
	    oldcenter.x=oldcenter.x+dx;	  
		click_x=click_x+dx;  	
		View_schedajp[i_pedinajp].center=oldcenter;
	}
	
	if (spostay) {	
		oldcenter=View_schedajp[i_pedinajp].center;	    
	    oldcenter.y=oldcenter.y+dy;	  
		click_y=click_y+dy;  	
		View_schedajp[i_pedinajp].center=oldcenter;
	}
	
	
	center1  =View_schedajp[i_pedinajp].center;	
	center2.x=[self dimmiposxschedajp:i_pedinajp];
	center2.y=[self dimmiposyschedajp:i_pedinajp];
	dx=center1.x-center2.x;	
	dy=center1.y-center2.y;
    if (dx<0) {dx=-dx;};    if (dy<0) {dy=-dy;};
	if (dx>(dimxschedajp/2)) { 	locres=locreslocal;   }
	if (dy>(dimyschedajp/2)) { 	locres=locreslocal;   }
	
	
	return locres;
}


- (void) riposizionatuttejp                          {
	CGPoint locpt;
	for(int i=0; i<10   ;i++)  {
		locpt.x=[self dimmiposxschedajp:i];
		locpt.y=[self dimmiposyschedajp:i];
		View_schedajp[i].center=locpt;			
		View_schedajp[i].highlighted=NO;
	}
}


- (int) testmovejp                       : (int) dir {
	int locres;
	
	//	int oldmodxped;	int oldmodyped;  CGPoint locpt; 
	//	int dx; int dy;
	
	int x1; int x2;
	int y1; int y2;
	
	locres=-1;
	x1=posjpx[10];  x2=posjpx[11];
	y1=posjpy[10];  y2=posjpy[11];
	
	
	if (i_pedinajp==0) {
		if (dir==1) {	
			if (x1==x2)  {  
				if  (((y1==posjpy[i_pedinajp])   & (y2==posjpy[i_pedinajp]+1))	 ||
					 ((y1==posjpy[i_pedinajp]+1) & (y2==posjpy[i_pedinajp])) ) 
				{   if ((y1==posjpy[i_pedinajp]) & (x1==posjpx[i_pedinajp]-1)   ) locres=10;
					if ((y2==posjpy[i_pedinajp]) & (x2==posjpx[i_pedinajp]-1)   ) locres=11;  } } }	
	    if (dir==3) {
			if (x1==x2) {  
				if  (((y1==posjpy[i_pedinajp])   & (y2==posjpy[i_pedinajp]+1))	 ||
					 ((y1==posjpy[i_pedinajp]+1) & (y2==posjpy[i_pedinajp])) ) 
				{ 	if ((y1==posjpy[i_pedinajp]) & (x1==posjpx[i_pedinajp]+2)   ) locres=10;
					if ((y2==posjpy[i_pedinajp]) & (x2==posjpx[i_pedinajp]+2)   ) locres=11;	} }	}
		
		
		if (dir==2) {
			if (y1==y2) {
				if  (((x1==posjpx[i_pedinajp])   & (x2==posjpx[i_pedinajp]+1))	 ||
					 ((x1==posjpx[i_pedinajp]+1) & (x2==posjpx[i_pedinajp])) ) 
				{ 
					if ((y1==posjpy[i_pedinajp]+2) & (x1==posjpx[i_pedinajp])   ) locres=10;
					if ((y2==posjpy[i_pedinajp]+2) & (x2==posjpx[i_pedinajp])   ) locres=11;
				}	  } 	}
		if (dir==4) {
			if (y1==y2) {
				if  (((x1==posjpx[i_pedinajp])   & (x2==posjpx[i_pedinajp]+1))	 ||
					 ((x1==posjpx[i_pedinajp]+1) & (x2==posjpx[i_pedinajp])) ) 
				{	 
					if ((y1==posjpy[i_pedinajp]-1) & (x1==posjpx[i_pedinajp])   ) locres=10;
					if ((y2==posjpy[i_pedinajp]-1) & (x2==posjpx[i_pedinajp])   ) locres=11;
				}	  } 	}
		
		
	} 
	
	
	
	
	for(int i=1; i<5   ;i++)  { 
		if (i!=i_pedinajp) continue;
	    if (dir==1) {
			if ((y1==posjpy[i_pedinajp]) & (x1==posjpx[i_pedinajp]-1)   ) locres=10;
			if ((y2==posjpy[i_pedinajp]) & (x2==posjpx[i_pedinajp]-1)   ) locres=11;	}
		if (dir==3) {
			if ((y1==posjpy[i_pedinajp]) & (x1==posjpx[i_pedinajp]+2)   ) locres=10;
			if ((y2==posjpy[i_pedinajp]) & (x2==posjpx[i_pedinajp]+2)   ) locres=11;	}
		
		if (dir==2) {
			if (y1==y2) {
				if  (((x1==posjpx[i_pedinajp])   & (x2==posjpx[i_pedinajp]+1))	 ||
					 ((x1==posjpx[i_pedinajp]+1) & (x2==posjpx[i_pedinajp])) ) 
				{ 
					if ((y1==posjpy[i_pedinajp]+1) & (x1==posjpx[i_pedinajp])   ) locres=10;
					if ((y2==posjpy[i_pedinajp]+1) & (x2==posjpx[i_pedinajp])   ) locres=11;
				}	  } 	}
		
		if (dir==4) {
			if (y1==y2) {
				if  (((x1==posjpx[i_pedinajp])   & (x2==posjpx[i_pedinajp]+1))	 ||
					 ((x1==posjpx[i_pedinajp]+1) & (x2==posjpx[i_pedinajp])) ) 
				{	 
					if ((y1==posjpy[i_pedinajp]-1) & (x1==posjpx[i_pedinajp])   ) locres=10;
					if ((y2==posjpy[i_pedinajp]-1) & (x2==posjpx[i_pedinajp])   ) locres=11;
				}	  } 	}
		
		
	}  // 1-4
	
	
	if (i_pedinajp==5) {
		if (dir==1) {
			if (x1==x2)  {  
				if  (((y1==posjpy[i_pedinajp])   & (y2==posjpy[i_pedinajp]+1))	 ||
					 ((y1==posjpy[i_pedinajp]+1) & (y2==posjpy[i_pedinajp])) ) 
				{ 	if ((y1==posjpy[i_pedinajp]) & (x1==posjpx[i_pedinajp]-1)   ) locres=10;
					if ((y2==posjpy[i_pedinajp]) & (x2==posjpx[i_pedinajp]-1)   ) locres=11;	}	}	}
		if (dir==3) {
			if (x1==x2) {  
				if  (((y1==posjpy[i_pedinajp])   & (y2==posjpy[i_pedinajp]+1))	 ||
					 ((y1==posjpy[i_pedinajp]+1) & (y2==posjpy[i_pedinajp])) ) 
				{ 	if ((y1==posjpy[i_pedinajp]) & (x1==posjpx[i_pedinajp]+1)   ) locres=10;
					if ((y2==posjpy[i_pedinajp]) & (x2==posjpx[i_pedinajp]+1)   ) locres=11;	}	}	}
		if (dir==2) {
			if ((y1==posjpy[i_pedinajp]+2) & (x1==posjpx[i_pedinajp])   ) locres=10;
			if ((y2==posjpy[i_pedinajp]+2) & (x2==posjpx[i_pedinajp])   ) locres=11;	}
		if (dir==4) {
			if ((y1==posjpy[i_pedinajp]-1) & (x1==posjpx[i_pedinajp])   ) locres=10;
			if ((y2==posjpy[i_pedinajp]-1) & (x2==posjpx[i_pedinajp])   ) locres=11;	}
	} 
	
	
	
	for(int i=6; i<10   ;i++)  { 
		if (i!=i_pedinajp) continue;
		if (dir==1) {
			if ((y1==posjpy[i_pedinajp]) & (x1==posjpx[i_pedinajp]-1)   ) locres=10;
			if ((y2==posjpy[i_pedinajp]) & (x2==posjpx[i_pedinajp]-1)   ) locres=11;	}
		if (dir==3) {
			if ((y1==posjpy[i_pedinajp]) & (x1==posjpx[i_pedinajp]+1)   ) locres=10;
			if ((y2==posjpy[i_pedinajp]) & (x2==posjpx[i_pedinajp]+1)   ) locres=11;	}
		if (dir==2) {
			if ((y1==posjpy[i_pedinajp]+1) & (x1==posjpx[i_pedinajp])   ) locres=10;
			if ((y2==posjpy[i_pedinajp]+1) & (x2==posjpx[i_pedinajp])   ) locres=11;	}
		if (dir==4) {
			if ((y1==posjpy[i_pedinajp]-1) & (x1==posjpx[i_pedinajp])   ) locres=10;
			if ((y2==posjpy[i_pedinajp]-1) & (x2==posjpx[i_pedinajp])   ) locres=11;	}
	}
	return 	locres;
}

- (void) cambiajp                 : (int) ind        {
	int oldmodxped;	int oldmodyped;  CGPoint locpt; 
	int dx; int dy;
	int x1; int x2;
	int y1; int y2;
	
	//	View_schedajp[i_pedinajp].hidden=YES;
	if (b_versionedemo) {  	i_contamossedemojp++;	}
	
	x1=posjpx[10];  x2=posjpx[11];
	y1=posjpy[10];  y2=posjpy[11];
	
	
	if (i_pedinajp==0) {
		dx=posjpx[i_pedinajp]-posjpx[ind]; 
		dy=posjpy[i_pedinajp]-posjpy[ind]; 
		if (dx==1) {
			if (x1==x2)  {  
				if  (((y1==posjpy[i_pedinajp])   & (y2==posjpy[i_pedinajp]+1))	 ||
					 ((y1==posjpy[i_pedinajp]+1) & (y2==posjpy[i_pedinajp])) ) 
				{	posjpx[i_pedinajp]--;	  posjpx[10]++;  posjpx[10]++;  	posjpx[11]++;  posjpx[11]++; }	  }  	}		
		if (dx==-2) {
			if (x1==x2) {  
				if  (((y1==posjpy[i_pedinajp])   & (y2==posjpy[i_pedinajp]+1))	 ||
					 ((y1==posjpy[i_pedinajp]+1) & (y2==posjpy[i_pedinajp])) ) 
				{	posjpx[i_pedinajp]++;	  posjpx[10]--;    posjpx[10]--; 	posjpx[11]--;   posjpx[11]--; }	}	}
	    if (dy==1) {
			if (y1==y2) {
				if  (((x1==posjpx[i_pedinajp])   & (x2==posjpx[i_pedinajp]+1))	 ||
					 ((x1==posjpx[i_pedinajp]+1) & (x2==posjpx[i_pedinajp])) ) 
				{	posjpy[i_pedinajp]--;	  posjpy[10]++; posjpy[10]++;   	posjpy[11]++;   posjpy[11]++; }	  } 	}
		
		if (dy==-2) {
			if (y1==y2) {
				if  (((x1==posjpx[i_pedinajp])   & (x2==posjpx[i_pedinajp]+1))	 ||
					 ((x1==posjpx[i_pedinajp]+1) & (x2==posjpx[i_pedinajp])) ) 
				{	posjpy[i_pedinajp]++;	  posjpy[10]--; posjpy[10]--;   	posjpy[11]--;   posjpy[11]--; }	  } 	}
		
	} 
	
	
	
	
	for(int i=1; i<5   ;i++)  { 
		if (i!=i_pedinajp) continue;
		dx=posjpx[i_pedinajp]-posjpx[ind]; 
		dy=posjpy[i_pedinajp]-posjpy[ind]; 
	    if (dy==0) {
			if (dx==1) {
				oldmodxped=posjpx[i_pedinajp];	    oldmodyped=posjpy[i_pedinajp];
				posjpx[i_pedinajp]=posjpx[ind];	    posjpy[i_pedinajp]=posjpy[ind];
				posjpx[ind]=oldmodxped+1;    	    posjpy[ind]=oldmodyped;		
			}
			if (dx==-2) {
				oldmodxped=posjpx[i_pedinajp];	    oldmodyped=posjpy[i_pedinajp];
				posjpx[i_pedinajp]=posjpx[ind]-1;	posjpy[i_pedinajp]=posjpy[ind];
				posjpx[ind]=oldmodxped;    	        posjpy[ind]=oldmodyped;						
			}
		}
		if (dy==1) {
			if (y1==y2)  {  
				if  (((x1==posjpx[i_pedinajp])   & (x2==posjpx[i_pedinajp]+1))	 ||
					 ((x1==posjpx[i_pedinajp]+1) & (x2==posjpx[i_pedinajp])) ) 
				{	posjpy[i_pedinajp]--;	  posjpy[10]++;    	posjpy[11]++;   }	  } 	}
		if (dy==-1) {
			if (y1==y2)  {  
				if  (((x1==posjpx[i_pedinajp])   & (x2==posjpx[i_pedinajp]+1))	 ||
					 ((x1==posjpx[i_pedinajp]+1) & (x2==posjpx[i_pedinajp])) ) 
				{	posjpy[i_pedinajp]++;	  posjpy[10]--;    	posjpy[11]--;   }	  }		}
	}  // 1-4
	
	
	if (i_pedinajp==5) {
		dx=posjpx[i_pedinajp]-posjpx[ind]; 
		dy=posjpy[i_pedinajp]-posjpy[ind]; 
		
		if (dx==1) {
			if (x1==x2)  {  
				if  (((y1==posjpy[i_pedinajp])   & (y2==posjpy[i_pedinajp]+1))	 ||
					 ((y1==posjpy[i_pedinajp]+1) & (y2==posjpy[i_pedinajp])) ) 
				{	posjpx[i_pedinajp]--;	  posjpx[10]++;    	posjpx[11]++;   }	  }  	}		
		if (dx==-1) {
			if (x1==x2) {  
				if  (((y1==posjpy[i_pedinajp])   & (y2==posjpy[i_pedinajp]+1))	 ||
					 ((y1==posjpy[i_pedinajp]+1) & (y2==posjpy[i_pedinajp])) ) 
				{	posjpx[i_pedinajp]++;	  posjpx[10]--;    	posjpx[11]--;   }	}	}
	    if (dy==1) {
			if (dx==0) {
				oldmodxped=posjpx[i_pedinajp];	    oldmodyped=posjpy[i_pedinajp];
				posjpx[i_pedinajp]=posjpx[ind];	    posjpy[i_pedinajp]=posjpy[ind];
				posjpx[ind]=oldmodxped;    	        posjpy[ind]=oldmodyped+1;	}	}
		if (dy==-2) {
			if (dx==0) {
				oldmodxped=posjpx[i_pedinajp];	    oldmodyped=posjpy[i_pedinajp];
				posjpx[i_pedinajp]=posjpx[ind];	    posjpy[i_pedinajp]=posjpy[ind]-1;
				posjpx[ind]=oldmodxped;    	        posjpy[ind]=oldmodyped;			}	}
	} 
	
	
	
	for(int i=6; i<10   ;i++)  { 
		if (i!=i_pedinajp) continue;
		dx=posjpx[i_pedinajp]-posjpx[ind]; if (dx<0) dx=-dx;
		dy=posjpy[i_pedinajp]-posjpy[ind]; if (dy<0) dy=-dy;
		dx=dx+dy;
		if (dx>1) continue; 
		oldmodxped=posjpx[i_pedinajp];	oldmodyped=posjpy[i_pedinajp];
		posjpx[i_pedinajp]=posjpx[ind];	posjpy[i_pedinajp]=posjpy[ind];
		posjpx[ind]=oldmodxped;    	    posjpy[ind]=oldmodyped;
	}
	
	
	locpt.x=[self dimmiposxschedajp:i_pedinajp];	locpt.y=[self dimmiposyschedajp:i_pedinajp];	View_schedajp[i_pedinajp].center=locpt;	
	locpt.x=[self dimmiposxschedajp:10];	        locpt.y=[self dimmiposyschedajp:10]; 	        View_schedajp[10].center=locpt;		
	locpt.x=[self dimmiposxschedajp:11];	        locpt.y=[self dimmiposyschedajp:11]; 	        View_schedajp[11].center=locpt;		
	
	//	b_clicked=NO;
	
	[self testrisoltojp];
	
}


- (void) JP_ClickUp               : (CGPoint)Ptclick {
	if ([self TestInsidebackmain:Ptclick])    { [self p_startOpenMenu:1]; View_back.highlighted=NO; } ;
	if ([self TestInsidepedinajp:Ptclick]>=0) { View_schedajp[i_pedinajp].highlighted=NO; i_pedinajp=-1; }; 
	[self riposizionatuttejp ];
	b_clicked=NO;
}   // gioco Jay Pag

- (void) ijp_Clickdown            : (CGPoint)Ptclick {
	[self TestInsidebackmain:Ptclick];
	[self TestInsidesound:Ptclick];
	
	if ([self TestInsidepedinajp:Ptclick]>=0) {   click_x=Ptclick.x;   click_y=Ptclick.y; b_clicked=YES; } ;
}   

- (void) ijp_ClickMove            : (CGPoint)Ptclick {
	if (i_contamossejp<=0)
	{
		labdemojp.text=@"You must restart the game, Moves Left :" ;
		return;
	}
	[self TestInsidebackmain:Ptclick]; 
	int posvuota;
	posvuota = [self TestInsidepedinajpvuota:Ptclick];
	if ((i_pedinajp>=0) & (posvuota>=0)) { [self cambiajp:posvuota];  [self Suona2:0]; 
		i_contamossejp--;
		STR_loctime = @"";
		labcontamosse.text=[STR_loctime stringByAppendingFormat:	 @"%d" , i_contamossejp ]; 

	}   
} 


- (void) gover_ClickUp            : (CGPoint)Ptclick {
	if ([self TestInsidebackmain:Ptclick])    { 
		if (b_infase15)   [self p_startOpenMenu:0]; else [self p_startOpenMenu:1];
		View_back.highlighted=NO;    
	} ;
} 

- (void) gover_Click              : (CGPoint)Ptclick {
	[self TestInsidebackmain:Ptclick];
} 

- (void) scrivitime               : (int) tempo      {
	div_t locvalue; 	int secondi;	int minuti;	int ore;
	tempo= tempo / 30;
	locvalue = div(tempo ,60);
	secondi = locvalue.rem;  	minuti  = locvalue.quot;
	tempo  = locvalue.quot;
	locvalue = div(tempo ,60);
	minuti  = locvalue.rem; 	ore = locvalue.quot;
	STR_loctime = @"";
	if (ore>0)  STR_loctime = [STR_loctime stringByAppendingFormat:	 @"%d° : %d' : %d''", ore, minuti, secondi];
	else STR_loctime = [STR_loctime stringByAppendingFormat:	 @"%d' : %d''", minuti, secondi];
	Label_Time.text=STR_loctime;
}


- (void) i15_game                                    {
	i_timegioco15++;
	[self scrivitime:i_timegioco15];
	
}

- (void) JP_game                                     {
	i_timegiocojp++;
	[self scrivitime:i_timegiocojp];
}


- (void) p_prerun2giochi {
	static int counter = 0;
	counter++; if(counter>=7*30) {    self.gameState=kstate_run2giochi;  }
}

//   DID LOAD
- (void)viewDidLoad                                  {
    [super viewDidLoad        ];	
	[self  setupnomikey       ];
   	[self  setupvariabili     ];
	[self  Inverti_fissavariabili   ];
	[self  loadgraficadigits        ];
	[self  loadgraficagamebase15    ];
	[self  loadgraficagameJayPag    ];
	[self  loadgraficamenu    ];
	[self  initSound          ];
	
	[NSTimer scheduledTimerWithTimeInterval:0.0333 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
	
	self.gameState=kstate_run2giochi;
}



- (void)gameLoop                                     {
	switch (self.gameState) {
		case kstate_prerun2giochi: [self p_prerun2giochi];  break; 
			
		case kstate_open15:        [self p_open15];      break; 
		case kstate_openjp:        [self p_openjp];      break; 
	    case kstate_openMenu15: 
		case kstate_openMenujp:    [self p_MenuOpen];    break;
        case kstate_closemenu:     [self p_MenuClose];   break;
			
		case kstate_InfoOpen:      [self p_InfoOpen];	 break;
		case kstate_InfoClose:     [self p_InfoClose];	 break;
			
		case kstate_RecordOpen:    [self p_RecordOpen];  break;
		case kstate_RecordClose:   [self p_RecordClose]; break;
			
		case kstate_TutorialOpen:  [self p_TutorialOpen];  break;
		case kstate_TutorialClose: [self p_TutorialClose];  break;
			
		case kstate_close15jp:     [self p_close15jp];	 break;
		case kstate_inGame15:      [self i15_game   ];   break;
        case kstate_inGamejp:      [self JP_game    ];   break;
			
		case kstate_SolvedOpen:    [self p_SolvedOpen ];   break;
		case kstate_SolvedRun:     [self p_SolvedRun ];   break;
			
			
		default :	 break;
	}
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint thumbPoint;
	UITouch *thumb = [[event allTouches] anyObject];
	thumbPoint = [thumb locationInView:thumb.view];	
	switch (self.gameState) {
		case kstate_MenuRun15        : 
		case kstate_MenuRunjp        : [self  TestInsideMenu      :  thumbPoint ]; break;
		case kstate_Info             : [self  TestInsidebackpanel :  thumbPoint ]; break;
		case kstate_Record           : [self  TestInsidebackpanel :  thumbPoint ]; break;
		case kstate_Tutorial         : [self  TestInsidebackpanel :  thumbPoint ]; break;
		case kstate_inGame15         : [self  i15_Clickdown       :  thumbPoint ]; break;
        case kstate_inGamejp         : [self  ijp_Clickdown       :  thumbPoint ]; break;
			
		case kstate_SolvedRun        : [self  gover_Click         :  thumbPoint ]; break;
		default :	 break;
	}	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint thumbPoint;
	UITouch *thumb = [[event allTouches] anyObject];
	thumbPoint = [thumb locationInView:thumb.view];	
	switch (self.gameState) {
		case kstate_MenuRun15        : 
		case kstate_MenuRunjp        : [self  TestInsideMenu      :  thumbPoint ]; break;
		case kstate_Info             : [self  TestInsidebackpanel :  thumbPoint ]; break;
		case kstate_Record           : [self  TestInsidebackpanel :  thumbPoint ]; break;
		case kstate_Tutorial         : [self  TestInsidebackpanel :  thumbPoint ]; break;
		case kstate_inGame15         : [self  i15_ClickMove       :  thumbPoint ]; break;
        case kstate_inGamejp         : [self  ijp_ClickMove       :  thumbPoint ]; break;
		case kstate_SolvedRun        : [self  gover_Click         :  thumbPoint ]; break;
		default :	 break;
	}	
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint thumbPoint;
	UITouch *thumb = [[event allTouches] anyObject];
	thumbPoint = [thumb locationInView:thumb.view];
	switch (self.gameState) {
		case kstate_run2giochi      : [self  clickup2giochi   :  thumbPoint ]; break;
		case kstate_MenuRun15       : [self  clickupMenu15    :  thumbPoint ]; break;
		case kstate_MenuRunjp       : [self  clickupMenujp    :  thumbPoint ]; break;
		case kstate_Info            : [self  TestUPInsidebackpanel :  thumbPoint ]; break;
		case kstate_Record          : [self  TestUPInsidebackpanel :  thumbPoint ]; break;
		case kstate_Tutorial        : [self  TestUPInsidebackpanel :  thumbPoint ]; break;
        case kstate_inGame15        : [self  i15_ClickUp      :  thumbPoint ]; break;
        case kstate_inGamejp        : [self  JP_ClickUp       :  thumbPoint ]; break;
		case kstate_SolvedRun       : [self  gover_ClickUp         :  thumbPoint ]; break;
			
		default :	 break;
	}
	
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	
	[Pagina1             release];
	[Pagina2             release];
	[Pagina3             release];
	[soundPlayerThread   release];
	for (int i=0; i< NUMSOUNDS; i++)  { [effectPlayer[i]    release]; };
	
	[img_sfondo          release];
	[View_sfondo         release];
	[img_title15         release];
	[img_titlejp         release];
	[View_title15        release];
	[View_titlejp        release];
	[Label_Time          release];
	[img_sottotime15     release];
	[img_sottotimejp     release];
	[View_sottotime      release];
	
	[img_back            release];
	[img_backh           release];
	[View_back           release];
	[img_sound           release];
	[img_soundh          release];
	[View_sound          release];
	[View_backpanel      release];
	
	[img_panel           release];
	[View_panel          release];
	[OtherGamesButton    release];
	[View_title15record  release];
	[View_titlejprecord  release];
	[img_solution15      release];
	[img_solutionjp      release];
	[View_solution15     release];
	[View_solutionjp     release];
	
	for (int i=0; i< 5; i++)  {	[Label_info[i]   release]; };
	for (int i=0; i< 6; i++)  {	[Label_rules[i]  release]; };
	
	for (int i=0; i<10; i++)  {	[Label_records15[i]  release]; };
	for (int i=0; i<10; i++)  {	[Label_recordsjp[i]  release]; };
	
	[STR_seconds         release];
	[STR_minuti          release];
	[STR_ore             release];
	[STR_loctime         release];
	[STR_dots            release];
	
	for (int i=0; i<14; i++)  {	[img_digits[i]  release]; };
	
	[img_menu15          release];
	[img_menu15h         release];
	[img_solved          release];
	[View_solved         release];
	[img_menujp          release];
	[img_menujph         release];
	
	for (int i=0; i<NUMLABELMENU; i++)  {	[View_menu15[i]  release]; 		[labMenu15[i]    release]; 
		[View_menujp[i]  release]; 		[labMenujp[i]    release]; 	};
	
	[img_base15          release];
	[img_scheda15        release];
	[img_scheda15h       release];
	[View_base15         release];
	[View_supporto15     release];
	
	[Key_primaapertura   release];
	[Key_intvolume       release];
	[Key_time15          release];
	[Key_timejp          release];
	
	[View_basejp         release];
	[View_supportojp     release];
	[img_basejp          release];
	
	for (int i=0; i<15; i++)  {	[View_scheda15[i]  release]; [View_overscheda15[i]    release]; };
	for (int i=0; i<6; i++)  {	[View_overscheda15b[i]  release]; 	};
	for (int i=0; i<4; i++)  {	[img_schedajp[i]   release]; 	[img_schedajph[i]  release]; };
	for (int i=0; i<12; i++) {	[Key_posxjp[i]     release]; 	[Key_posyjp[i]     release]; [View_schedajp[i]  release]; 	};
	for (int i=0; i<10; i++) {	[img_overschedajph[i]  release]; [View_overschedajp[i]  release]; [Key_intrecords15[i]  release]; 
		[Key_intrecordsjp[i]  release]; 	};
	for (int i=0; i<16; i++)  {	[Key_posx15[i]  release]; 		[Key_posy15[i]  release]; 	};
	
    [super dealloc];
}

@end

