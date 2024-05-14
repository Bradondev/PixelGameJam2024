extends Resource
class_name  Gun

@export_enum("ShotGun", "Pistol", "Sniper","SMG","Rifle") var GunType: int
@export var Sprite : Texture2D
@export var CrossHairSprite : Texture2D
@export var BulletSpawnPoint: Vector2 = Vector2.ZERO
@export_multiline var Description : String
@export_category("Gun  Properties")
@export var ROF : int # Bullets per seconds
@export var BaseDamage : int
@export var MagSize: int
@export var Spread: int # in degrees 

@export var BulletType : ItemType
var CurrentMagSize: int = 0


func LoadMag(Size:int):
	CurrentMagSize = Size
