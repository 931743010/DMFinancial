//
//  NSManagedObject+Mapping.h
//  MagicalData
//
//  Created by Mac on 13-9-13.
//  Copyright (c) 2013年 nidom. All rights reserved.
//


@interface MappingRuntimeHelper : NSObject {
	
}
/**
 *	Judge  if the property is readOnly
 *
 *	@param	klass	the property'owner class
 *	@param	propertyName
 *
 *	@return	<#return value description#>
 */
+ (BOOL)isPropertyReadOnly:(Class)klass propertyName:(NSString*)propertyName;
/**
 *	 return property'class by the property'name
 *
 *	@param	propertyName	<#propertyName description#>
 *	@param	klass	<#klass description#>
 *
 *	@return	<#return value description#>
 */
+ (Class)propertyClassForPropertyName:(NSString *)propertyName ofClass:(Class)klass;


@end
