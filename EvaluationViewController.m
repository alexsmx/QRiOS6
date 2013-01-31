//
//  EvaluationViewController.m
//  prueba
//
//  Created by Alejandro on 1/25/13.
//  Copyright (c) 2013 somapps. All rights reserved.
//

#import "EvaluationViewController.h"

@interface EvaluationViewController ()
@property (weak, nonatomic) IBOutlet UIView *escala;
@property (strong,nonatomic) NSMutableArray *calificaciones;
@property (nonatomic) NSInteger *calificacionSeleccionada;
@property float xpos;
@property int highlightednumber;
@property float anchoTecla;

@end

@implementation EvaluationViewController
@synthesize xpos;
@synthesize anchoTecla;
@synthesize highlightednumber;

- (void)handleTap:(id)recognizer{
    
    CGPoint location = [recognizer locationInView:self.view];
    self.xpos = location.x;
    int oldhighlightednumber=self.highlightednumber;
    self.highlightednumber= (int)floor(self.xpos/self.anchoTecla);
    NSLog(@"xpos: %d", self.highlightednumber);
    UILabel *etiqueta = [self.calificaciones objectAtIndex:self.highlightednumber];
    UILabel *etiquetaold = [self.calificaciones objectAtIndex:oldhighlightednumber];
    etiquetaold.highlighted=NO;
    etiqueta.highlighted=YES;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer{
    int oldhighlightednumber=self.highlightednumber;
    CGPoint location = [recognizer locationInView:self.view];
    self.xpos = location.x;
    self.highlightednumber= (int)floor(self.xpos/self.anchoTecla);
    NSLog(@"xpos: %d", self.highlightednumber);
    UILabel *etiqueta = [self.calificaciones objectAtIndex:self.highlightednumber];
    UILabel *etiquetaold = [self.calificaciones objectAtIndex:oldhighlightednumber];
    etiquetaold.highlighted=NO;
    etiqueta.highlighted=YES;
}

- (NSMutableArray *)calificaciones{
    if (! _calificaciones) {
         _calificaciones=[NSMutableArray arrayWithCapacity:10];
    }
    return _calificaciones;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated{
    CGSize windowsize= self.escala.frame.size;
    NSLog(@"Tamaño %f, %f", windowsize.width, windowsize.height);
    CGFloat alto= windowsize.height;
    CGFloat ancho=windowsize.width/10;
    self.anchoTecla=ancho;
    NSMutableArray *colores=[NSMutableArray arrayWithObjects:
     [UIColor colorWithRed:(181.0/255.0) green:(82.0/255.0) blue:(84.0/255.0) alpha:1.0],
     [UIColor colorWithRed:(217.0/255.0) green:(88.0/255.0) blue:(97.0/255.0) alpha:1.0],
     [UIColor colorWithRed:(240.0/255.0) green:(146.0/255.0) blue:(89.0/255.0) alpha:1.0],
     [UIColor colorWithRed:(245.0/255.0) green:(182.0/255.0) blue:(84.0/255.0) alpha:1.0],
     [UIColor colorWithRed:(250.0/255.0) green:(219.0/255.0) blue:(89.0/255.0) alpha:1.0],
     [UIColor colorWithRed:(253.0/255.0) green:(235.0/255.0) blue:(73.0/255.0) alpha:1.0],
     [UIColor colorWithRed:(228.0/255.0) green:(238.0/255.0) blue:(90.0/255.0) alpha:1.0],
     [UIColor colorWithRed:(203.0/255.0) green:(231.0/255.0) blue:(142.0/255.0) alpha:1.0],
     [UIColor colorWithRed:(125.0/255.0) green:(195.0/255.0) blue:(132.0/255.0) alpha:1.0],
     [UIColor colorWithRed:(109.0/255.0) green:(157.0/255.0) blue:(120.0/255.0) alpha:1.0],nil];
    
    CGFloat x=0;
    for (int i =0; i<10; i++) {
        NSLog(@"i: %d", i);
        CGRect  viewRect = CGRectMake(x, 0, ancho, alto);
        x=x+ancho;
        UIView* myView = [[UIView alloc] initWithFrame:viewRect];
        [myView setBackgroundColor:(UIColor *)[colores objectAtIndex:i]];
        myView.tag=i+1;
        UILabel *etiquetaNumero=[[UILabel alloc] initWithFrame:CGRectMake(ancho/20.0, alto/2.0, ancho-(ancho/20.0), alto/10.0)];
        etiquetaNumero.text = [NSString stringWithFormat:@"%d",i+1];
        [etiquetaNumero setBackgroundColor:[UIColor clearColor]];
        etiquetaNumero.font = [UIFont fontWithName:@"Arial" size: 75.0];
        etiquetaNumero.textAlignment=UITextAlignmentCenter;
        etiquetaNumero.textColor=[UIColor whiteColor];
        etiquetaNumero.highlightedTextColor=[UIColor redColor];
        etiquetaNumero.shadowColor = [UIColor blackColor];
        etiquetaNumero.tag=i+1;
        [self.calificaciones addObject:etiquetaNumero];
        [myView addSubview:etiquetaNumero];
        [self.escala addSubview:myView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEscala:nil];
    [super viewDidUnload];
}

@end
