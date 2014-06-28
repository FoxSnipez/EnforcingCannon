AddCSLuaFile()
SWEP.Base = "weapon_base"
SWEP.PrintName		= "Enforcing Cannon"
SWEP.Slot		                   = 1
SWEP.SlotPos		= 1		
SWEP.DrawAmmo		= true				
SWEP.DrawCrosshair		= true		
SWEP.ViewModel		= "models/weapons/v_physcannon.mdl"	
SWEP.WorldModel		= "models/weapons/w_crossbow.mdl"	
SWEP.ReloadSound		= "Weapon_Crossbow.Reload"	
SWEP.HoldType		= "crossbow"			
-- Other settings
SWEP.Weight		= 4			
SWEP.AutoSwitchTo		= true			
SWEP.Spawnable		= true		
SWEP.AdminOnly    = true
-- Weapon info
SWEP.Author		= "FoxSnipez (Axel)"		
SWEP.Contact		= " "		
SWEP.Purpose		= "To enforce the law, or anything else xD."	
SWEP.Instructions	= "LMB to shoot a lethal bullet. RMB to shoot a bullet that injures."		

-- Primary fire settings
SWEP.Primary.Sound			= "Weapon_PhysCannon.Launch"	
SWEP.Primary.Damage		= 100
SWEP.Primary.NumShots		= 1	
SWEP.Primary.Recoil			= 0			
SWEP.Primary.Cone			= 1		
SWEP.Primary.Delay			= 1,44
SWEP.Primary.ClipSize		= 1		
SWEP.Primary.DefaultClip	                  = 1	
SWEP.Primary.Tracer			= 1			
SWEP.Primary.Force			= 200	
SWEP.Primary.Automatic		= 4	
SWEP.Primary.Ammo		= "XBowBolt"	
SWEP.Category 			= "FoxSnipez's Weapons"

-- Secondary fire settings
SWEP.Secondary.Sound		= "Weapon_PhysCannon.Launch"
SWEP.Secondary.Damage		= 10			
SWEP.Secondary.NumShots		= 1			
SWEP.Secondary.Recoil		= 0			
SWEP.Secondary.Cone		= 1			
SWEP.Secondary.Delay		= 1,44			
SWEP.Secondary.ClipSize		= 3		
SWEP.Secondary.DefaultClip	                  = 3			
SWEP.Secondary.Tracer		= 1			
SWEP.Secondary.Force		= 200			
SWEP.Secondary.Automatic	           	= false
SWEP.Secondary.Ammo		= "XBowBolt"		




function SWEP:Initialize()			
end

function SWEP:PrimaryAttack()		
	if ( !self:CanPrimaryAttack() ) then return end		
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Primary.NumShots				
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 90, 0 )
		bullet.Tracer = self.Primary.Tracer				
		bullet.Force = self.Primary.Force				
		bullet.Damage = self.Primary.Damage				
		bullet.AmmoType = self.Primary.Ammo				
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )	
	self.Owner:MuzzleFlash()							
	self.Owner:SetAnimation( PLAYER_ATTACK1 )			
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch(Angle( -self.Primary.Recoil, 0, 0 ))
	if (self.Primary.TakeAmmoPerBullet) then			
		self:TakePrimaryAmmo(self.Primary.NumShots)
	else
		self:TakePrimaryAmmo(1)
	end
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )	
end

function SWEP:SecondaryAttack()		
	if ( !self:CanSecondaryAttack() ) then return end	
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Secondary.NumShots			
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Secondary.Cone / 90, self.Secondary.Cone / 90, 0 )	
		bullet.Tracer = self.Secondary.Tracer			
		bullet.Force = self.Secondary.Force				
		bullet.Damage = self.Secondary.Damage			
		bullet.AmmoType = self.Secondary.Ammo			
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )	
	self.Owner:MuzzleFlash()										
	self.Weapon:EmitSound(Sound(self.Secondary.Sound))	
	self.Owner:ViewPunch(Angle( -self.Secondary.Recoil, 0, 0 ))
	if (self.Secondary.TakeAmmoPerBullet) then			
		self:TakeSecondaryAmmo(self.Secondary.NumShots)
	else
		self:TakeSecondaryAmmo(1)
	end
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )	
end

function SWEP:Think()				
end

function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	return true
end

function SWEP:Deploy()				
	return true
end

function SWEP:Holster()				
	return true
end

function SWEP:OnRemove()			
end

function SWEP:OnRestore()			
end

function SWEP:Precache()			
end

function SWEP:OwnerChanged()		
end