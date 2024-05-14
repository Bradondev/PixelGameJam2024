extends Resource
class_name  Gun

@export_enum("ShotGun", "Pistol", "Sniper","SMG","Rifle") var GunType: int
@export var Sprite : Texture2D
@export var CrossHairSprite : Texture2D
@export var BulletSpawnPoint: Vector2 = Vector2.ZERO
@export_multiline var Description : String
@export_category("Gun  Properties")
@export var ROF : float =.2 # Bullets per seconds
@export var BaseDamage : int
@export var MagSize: int
@export_range(0, 360) var Arc: int= 0 # in degrees 
@export var ButtetCount: int =1
@export var BulletTypeItem : ItemType
@export var BulletScene: PackedScene

var CurrentMagSize: int = 0


func LoadMag(Size:int):
	CurrentMagSize = Size
