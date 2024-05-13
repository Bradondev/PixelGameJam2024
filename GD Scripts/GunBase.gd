extends Resource
class_name  Gun

@export_enum("ShotGun", "Pistol", "Sniper","SMG","Rifle") var GunType: int
@export var Sprite : Texture2D
@export var CrossHairSprite : Texture2D

@export_multiline var Description : String
@export_category("Gun  Properties")
@export var ROF : int # Bullets per seconds
@export var BaseDamage : int
@export var MagSize: int
@export var Spread: int # in degrees 

var CurrentMagSize: int
