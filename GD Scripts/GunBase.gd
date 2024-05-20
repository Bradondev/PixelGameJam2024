extends Resource
class_name  Gun

@export_enum("shotty", "pistol", "sniper","smg","ar") var GunType: String
@export var Sprite : Texture2D
@export var CrossHairSprite : Texture2D
@export var BulletSpawnPoint: Vector2 = Vector2.ZERO
@export_multiline var Description : String
@export_category("Gun  Properties")
@export var ROF : float =.2 # Bullets per seconds
@export var BaseDamage : int
@export var MagSize: int
@export var ShotSound: AudioStreamMP3
@export_range(0, 360) var Arc: int= 0 # in degrees 
@export var ButtetCount: int =1
@export var BulletTypeItem : ItemType
@export var BulletScene: PackedScene
@export var ReloadTime : float
@export_range(0, 100) var Accuracy : int = 100
@export_enum("camo","desert","artic") var Type: String
var CurrentMagSize: int = 0

var nobulletsound: AudioStreamMP3


func LoadMag(Size:int):
	CurrentMagSize += Size
	if CurrentMagSize >= MagSize:
		CurrentMagSize = MagSize
