//
//  JayPagFreeViewController.h
//  JayPagFree
//
//  Created by Carlo Macor on 29/01/10.
//  Copyright Carlo Macor 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define NUMLABELMENU	6
#define NUMSOUNDS       5


@interface JayPagFreeViewController : UIViewController {

	
	NSInteger	gameState;					
	NSInteger   sceltamenu;					
	
	UIImageView	*Pagina1;    // 15
	UIImageView	*Pagina2;    // jp
	UIImageView	*Pagina3;    // menu
	
    // sound
	NSThread      *soundPlayerThread;				
	AVAudioPlayer *effectPlayer[NUMSOUNDS];			
	float         f_volindice[NUMSOUNDS];			
	int          i_contasound;
	
	// sfondo
	UIImage 	*img_sfondo;
	UIImageView	*View_sfondo;  
	UIImage 	*img_title15;
	UIImage 	*img_titlejp;
	UIImageView	*View_title15;  
	UIImageView	*View_titlejp;  
	UILabel     *Label_Time;
	UIImage 	*img_sottotime15;
	UIImage 	*img_sottotimejp;
	UIImageView	*View_sottotime;  
	
	
	// back
	UIImage 	*img_back;
	UIImage 	*img_backh;
	UIImageView	*View_back;  
	UIImage 	*img_sound;
	UIImage 	*img_soundh;
	UIImageView	*View_sound;  
	UIImageView	*View_backpanel;  
	
	
	
	// panel per info record .....
	UIImage 	*img_panel;
	UIImageView	*View_panel;  
	UILabel     *Label_info[5];
	UIButton    *OtherGamesButton;
	UIImageView	*View_title15record;  
	UIImageView	*View_titlejprecord;  
	UILabel     *Label_records15[10];
	UILabel     *Label_recordsjp[10];
	UIImage 	*img_solution15;
	UIImage 	*img_solutionjp;
	UIImageView	*View_solution15;  
	UIImageView	*View_solutionjp;  
	UILabel     *Label_rules[6];
	
	
	NSString    *STR_seconds;
	NSString    *STR_minuti;
	NSString    *STR_ore;
	NSString    *STR_loctime;
	NSString    *STR_dots;
	
	
	// digits
	UIImage 	*img_digits[14];
	
	// menu
	UIImage 	*img_menu15;
	UIImage 	*img_menu15h;
	UIImageView	*View_menu15[NUMLABELMENU];  
	UILabel     *labMenu15[NUMLABELMENU];
	
	UIImage 	*img_solved;
	UIImageView	*View_solved;  
	
	
	UIImage 	*img_menujp;
	UIImage 	*img_menujph;
	UIImageView	*View_menujp[NUMLABELMENU];  
	int         i_dimx2opzmenu;
	int         i_dimy2opzmenu;
	UILabel     *labMenujp[NUMLABELMENU];
	
	bool        b_infase15;
	bool        b_clicked;
	bool        b_gameOver15;
	bool        b_gameOverjp;
	
	// 15
	UIImage 	*img_base15;
	UIImage 	*img_scheda15;
	UIImage 	*img_scheda15h;
	UIImageView	*View_scheda15[15];  
	UIImageView	*View_overscheda15[15];  
	UIImageView	*View_overscheda15b[6];  
	UIImageView	*View_base15;  
	UIImageView	*View_supporto15;  
	int         pos15x[16];
	int         pos15y[16];
	int         dimxscheda15;
	int         dimyscheda15;
	float       f_scale15;
	int         i_pedina15;
	int         i_timegioco15;
	int         i_UltimoRecord15;
	int         i_introducedrecord15;
	int         posfinale15x[16];
	int         posfinale15y[16];
	int         i_contatimesolved15;
	
	int         click_x;
	int         click_y;
	
	
	// wjp
	UIImage 	*img_basejp;
	UIImage 	*img_schedajp [4];
	UIImage 	*img_schedajph[4];
	UIImage 	*img_overschedajph[10];
	UIImageView	*View_schedajp[12];  
	UIImageView	*View_overschedajp[10];  
	UIImageView	*View_basejp;  
	UIImageView	*View_supportojp;  
	int         posjpx[12];
	int         posjpy[12];
	int         dimxschedajp;
	int         dimyschedajp;
	float       f_scalejp;
	int         i_pedinajp;
	int         i_timegiocojp;
	int         i_UltimoRecordjp;
	int         i_introducedrecordjp;
    int         i_contamossedemojp;
	int         i_contatimesolvedjp;
	int         i_contamossejp;
	UILabel     *labcontamosse;
	UILabel     *labdemojp;
	UIButton    *comprafinale;


	
	// records
	int         i_record15[10];
	int         i_recordjp[10];
	bool        b_primaapertura;						
	float       f_soundlevel;	
	bool        b_usedrecord15;
	bool        b_usedrecordjp;
    bool        b_versionedemo;
	
	NSString    *Key_intrecords15 [10] ;
	NSString    *Key_intrecordsjp [10] ;
	NSString    *Key_primaapertura   ;
	NSString    *Key_intvolume;
	NSString    *Key_time15;
	NSString    *Key_timejp;
	
	NSString    *Key_posx15 [16] ;
	NSString    *Key_posy15 [16] ;
	NSString    *Key_posxjp [12] ;
	NSString    *Key_posyjp [12] ;
	
}


@property(nonatomic) NSInteger		gameState;
@property(nonatomic) NSInteger		sceltamenu;

- (void) fissavariabili;

@end

