//
//  GCTViewController.m
//  GCTest
//
//  Created by Roberto Scarciello on 24/01/14.
//  Copyright (c) 2014 Roberto Scarciello. All rights reserved.
//

#import "GCTViewController.h"

@interface GCTViewController ()

@end

@implementation GCTViewController

@synthesize controllerConnected = _controllerConnected;
@synthesize gameController = _gameController;

@synthesize status = _status;
@synthesize vendor = _vendor;
@synthesize LS = _LS;
@synthesize RS = _RS;
@synthesize LT = _LT;
@synthesize RT = _RT;
@synthesize A = _A;
@synthesize B = _B;
@synthesize X = _X;
@synthesize Y = _Y;
@synthesize up = _up;
@synthesize left = _left;
@synthesize right = _right;
@synthesize down = _down;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _controllerConnected = NO;
        // Inizializza gli observer per monitorare la connessione di un controller
        // Quando si collega un controller è possibile definire un metodo che gestisca l'azione, così come è possibile fare lo stesso quando avviene la disconnessione
        // ma questo è valido solo per i controller fisicamente collegati al dispositivo.
        // Per i controller wireless è necessario avviare un metodo che li gestisca propriamente.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerConnectionStateChanged) name:GCControllerDidConnectNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerConnectionStateChanged) name:GCControllerDidDisconnectNotification object:nil];
        
        [GCController startWirelessControllerDiscoveryWithCompletionHandler:^{ [self controllerConnectionStateChanged]; }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Il seguente metodo si occupa di registrare il controller e proseguire quindi nella sua gestione
 Esistono due metodi per gestire un controller il primo è interrogare lo stato del controller nel
 loop principale dell'applicazione.
 In genere questo loop avviene quando lo schermo ha appena terminato di essere disegnato e ci si
 accinge a ridisegnarlo nuovamente con la posizione degli oggetti aggiornati.
 Questo tipo di approccio, ovvero il polling, permette di gestire l'evento del controller nel
 momento più appropriato, anche se questo può implicare un maggior tempo tra il termine del disegno
 del frame ed il successivo, richiedendo quindi la scrittura di codice ottimizzato.
 Un altro metodo è quello di registrare per uno o più elementi di interesse un trigger tramite un
 handler ad una funzione. In questo modo sarà il sistema ad avvisarci quando l'utente compie un'azione
 lasciandoci il compito di reagire ad essa. Lo svantaggio è che non facendo parte del ciclo principale
 essa può avvenire in qualsiasi momento e, quindi, è necessario valutare se gestire l'input al
 momento, inserirlo in una coda di eventi o scartarlo.
 Non esiste un metodo corretto o sbagliato nel metodo di gestione, sta allo sviluppatore scegliere
 quello che ritiene più appropriato.
 La scelta migliore spesso si rivela essere un misto tra le due soluzioni ad esempio con gli handler si
 può gestire il tasto pausa mentre i pulsanti e le levette possono essere gestite nel loop principale.

 Per questo esempio adopererò gli handler che andranno a manipolare delle istanze di componenti sullo
 schermo del dispositivo.
 Essendo questo a scopo didattico è stato possibile inserire la routine di discovery e di impostazione
 a livello di controller, così come ai singoli handler è permessa la manipolazione diretta dell'interfaccia.
 Nella realizzazione di un gioco l'intera gestione del controller è conveniente che sia allocata in un
 singleton o in un'istanza di una classe sempre raggiungibile.
*/

- (void)controllerConnectionStateChanged {
    NSString *infoString = @"";
    // La classe GCController mette a disposizione un metodo di classe, denominato controllers, che restituisce l'elenco di controllers collegati al dispositivo
    // Per questo esempio si suppone che vi sia collegato un solo controller per volta
    if([[GCController controllers] count]>0) {
        infoString = @"Controller connected!";
        _gameController = [GCController controllers][0];
        _controllerConnected = YES;
        if(_gameController.extendedGamepad) {
            // Registro gli handler per un controller esteso
            GCExtendedGamepad *profile = _gameController.extendedGamepad;
            
            // Shoulders buttons
            profile.leftShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _LS.backgroundColor = [UIColor darkGrayColor];
                else
                    _LS.backgroundColor = [UIColor lightGrayColor];
            };
            profile.rightShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _RS.backgroundColor = [UIColor darkGrayColor];
                else
                    _RS.backgroundColor = [UIColor lightGrayColor];
            };
            
            // Triggers buttons
            profile.leftTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _LT.backgroundColor = [UIColor darkGrayColor];
                else
                    _LT.backgroundColor = [UIColor lightGrayColor];
            };
            profile.rightTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _RT.backgroundColor = [UIColor darkGrayColor];
                else
                    _RT.backgroundColor = [UIColor lightGrayColor];
            };
            
            // Buttons
            profile.buttonA.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _A.textColor = [UIColor redColor];
                else
                    _A.textColor = [UIColor blackColor];
            };
            profile.buttonB.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _B.textColor = [UIColor greenColor];
                else
                    _B.textColor = [UIColor blackColor];
            };
            profile.buttonX.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _X.textColor = [UIColor yellowColor];
                else
                    _X.textColor = [UIColor blackColor];
            };
            profile.buttonY.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _Y.textColor = [UIColor blueColor];
                else
                    _Y.textColor = [UIColor blackColor];
            };
            profile.buttonA.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _A.backgroundColor = [UIColor redColor];
                else
                    _A.backgroundColor = [UIColor clearColor];
            };
            profile.buttonB.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _B.backgroundColor = [UIColor greenColor];
                else
                    _B.backgroundColor = [UIColor clearColor];
            };
            profile.buttonX.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _X.backgroundColor = [UIColor yellowColor];
                else
                    _X.backgroundColor = [UIColor clearColor];
            };
            profile.buttonY.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _Y.backgroundColor = [UIColor blueColor];
                else
                    _Y.backgroundColor = [UIColor clearColor];
            };

            // D-Pad
            profile.dpad.valueChangedHandler = ^(GCControllerDirectionPad *dpad, float xValue, float yValue)
            {
                if(dpad.up.pressed)
                    _up.image = [UIImage imageNamed:@"upsel"];
                else
                    _up.image = [UIImage imageNamed:@"up"];
                if(dpad.down.pressed)
                    _down.image = [UIImage imageNamed:@"downsel"];
                else
                    _down.image = [UIImage imageNamed:@"down"];
                if(dpad.left.pressed)
                    _left.image = [UIImage imageNamed:@"leftsel"];
                else
                    _left.image = [UIImage imageNamed:@"left"];
                if(dpad.right.pressed)
                    _right.image = [UIImage imageNamed:@"rightsel"];
                else
                    _right.image = [UIImage imageNamed:@"right"];
            };
        } else {
            // Registro gli handler per un controller standard
            GCGamepad *profile = _gameController.gamepad;
            
            // Shoulders buttons
            profile.leftShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _LS.backgroundColor = [UIColor darkGrayColor];
                else
                    _LS.backgroundColor = [UIColor lightGrayColor];
            };
            profile.rightShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _RS.backgroundColor = [UIColor darkGrayColor];
                else
                    _RS.backgroundColor = [UIColor lightGrayColor];
            };
            
            // Buttons
            profile.buttonA.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _A.backgroundColor = [UIColor redColor];
                else
                    _A.backgroundColor = [UIColor clearColor];
            };
            profile.buttonB.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _B.backgroundColor = [UIColor greenColor];
                else
                    _B.backgroundColor = [UIColor clearColor];
            };
            profile.buttonX.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _X.backgroundColor = [UIColor yellowColor];
                else
                    _X.backgroundColor = [UIColor clearColor];
            };
            profile.buttonY.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
            {
                if (pressed)
                    _Y.backgroundColor = [UIColor blueColor];
                else
                    _Y.backgroundColor = [UIColor clearColor];
            };
            
            // D-Pad
            profile.dpad.valueChangedHandler = ^(GCControllerDirectionPad *dpad, float xValue, float yValue)
            {
                if(dpad.up.pressed)
                    _up.image = [UIImage imageNamed:@"upsel"];
                else
                    _up.image = [UIImage imageNamed:@"up"];
                if(dpad.down.pressed)
                    _down.image = [UIImage imageNamed:@"downsel"];
                else
                    _down.image = [UIImage imageNamed:@"down"];
                if(dpad.left.pressed)
                    _left.image = [UIImage imageNamed:@"leftsel"];
                else
                    _left.image = [UIImage imageNamed:@"left"];
                if(dpad.right.pressed)
                    _right.image = [UIImage imageNamed:@"rightsel"];
                else
                    _right.image = [UIImage imageNamed:@"right"];
            };
        }
    } else {
        // Il numero di controllers è pari a 0, sono stati tutti disconnessi
        if(_controllerConnected)
            infoString = @"Controller disconnected!";
        _gameController = nil;
        _controllerConnected = NO;
    }
    _status.text = infoString;
    _vendor.text = _gameController.vendorName;
}

@end
