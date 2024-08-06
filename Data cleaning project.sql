--Data cleaning

--select * 
--from [Nashvile].[dbo].[FilterDatabase]

--Converting data
--Select SaleDate,CONVERT(date,Saledate)
--from [Nashvile].[dbo].[FilterDatabase]

--Update  [Nashvile].[dbo].[FilterDatabase]
--Set SaleDate = CONVERT(date,Saledate)

--ALter table [Nashvile].[dbo].[FilterDatabase]
--ADD Saledateconverted Date;

--Update [Nashvile].[dbo].[FilterDatabase]
--Set Saledateconverted = CONVERT(date,Saledate)

--Filling up the data,(here property adddress is null somewhere)

--select *
--from [Nashvile].[dbo].[FilterDatabase]
--where PropertyAddress is null

--select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
--from [Nashvile].[dbo].[FilterDatabase] a
--Join [Nashvile].[dbo].[FilterDatabase] b 
--on a.[UniqueID ] <> b.[UniqueID ]
--Where a.[PropertyAddress] is null

--Update a
--SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
--from [Nashvile].[dbo].[FilterDatabase] a
--Join [Nashvile].[dbo].[FilterDatabase] b 
--on a.[UniqueID ] <> b.[UniqueID ]
--Where a.[PropertyAddress] is null



-- Breaking out Address into Individual Columns (Address, City, State)

--Select PropertyAddress
--From [Nashvile].[dbo].[FilterDatabase]
----Where PropertyAddress is null
----order by ParcelID

--SELECT
--SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
--, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

--From FilterDatabase


--ALTER TABLE FilterDatabase
--Add PropertySplitAddress Nvarchar(255);

--Update FilterDatabase
--SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


--ALTER TABLE FilterDatabase
--Add PropertySplitCity Nvarchar(255);

--Update FilterDatabase
--SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

--select *
--from FilterDatabase
----------------------------------------------------------------------------

--select [UniqueID ],OwnerName,PropertyAddress,SalePrice 
--from FilterDatabase
--group by [UniqueID ],PropertyAddress,OwnerName,SalePrice
--order by SalePrice Desc;

--select 
--PARSENAME(REPLACE(OwnerAddress,',','.'),3),
--PARSENAME(REPLACE(OwnerAddress,',','.'),2),
--PARSENAME(REPLACE(OwnerAddress,',','.'),1)
--from FilterDatabase

--ALTER TABLE filterDatabase
--ADD Splitowneraddress nvarchar(255);

--Update FilterDatabase
--Set Splitowneraddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3);

--select Splitowneraddress
--from FilterDatabase

--ALTER TABLE filterDatabase
--ADD Splitowneraddress1 nvarchar(255);


--Update FilterDatabase
--Set Splitowneraddress1 = PARSENAME(REPLACE(OwnerAddress,',','.'),2);

--select Splitowneraddress1
--from FilterDatabase


--ALTER TABLE filterDatabase
--ADD Splitowneraddress2 nvarchar(255);

--Update FilterDatabase
--Set Splitowneraddress2 = PARSENAME(REPLACE(OwnerAddress,',','.'),1);

--select Splitowneraddress2
--from FilterDatabase


--select DISTINCT(SoldAsVacant),COUNT(SoldAsVacant)
--from FilterDatabase
--group by SoldAsVacant
--order by 2
----HERE WE CAN SEE THAT THERE ARE SOME ROWS WITH 'Y' INSTEAD OF 'YES',SAME GOES FOR NO,SO CONVERTING 'Y' TO 'YES' AND VICE VERSA

--select SoldAsVacant,
--CASE when SoldAsVacant = 'Y' then 'Yes'
--     when SoldAsVacant = 'N' then 'No'
--	 ELSE SoldAsVacant
--	 END
--from FilterDatabase

--update FilterDatabase
--set SoldAsVacant = CASE when SoldAsVacant = 'Y' then 'Yes'
--     when SoldAsVacant = 'N' then 'No'
--	 ELSE SoldAsVacant
--	 END

-- Remove Duplicates

--WITH RowNumCTE AS(
--Select *,
--	ROW_NUMBER() OVER (
--	PARTITION BY ParcelID,
--				 PropertyAddress,
--				 SalePrice,
--				 SaleDate,
--				 LegalReference
--				 ORDER BY
--					UniqueID
--					) row_num 

--from FilterDatabase
----order by ParcelID
--)
--Select *
--From RowNumCTE
--Where row_num > 1
--Order by PropertyAddress

--DELETING UNUSED COLUMNS

--ALTER TABLE filterDatabase
--DROP COLUMN OwnerAddress,SaleDate,TaxDistrict,PropertyAddress


---SUPPOSE THE LANDVALUE,BUILDINGVALUE ARE SUPPOSED TO BE INCREASED  BY 0.2%,SO CHANGE TO THE NEW VALUE
--update FilterDatabase
--set BuildingValue = BuildingValue  - (BuildingValue * .02)

--update FilterDatabase
--set LandValue = LandValue  + (LandValue * .02)

--update FilterDatabase
--set TotalValue =  LandValue + BuildingValue

--select *
--from FilterDatabase

----REMOVING NUMBERS AFTER DECIMAL 
--update FilterDatabase
--set BuildingValue = FLOOR(BuildingValue); 

--update FilterDatabase
--set LandValue = FLOOR(LandValue); 

--update FilterDatabase
--set TotalValue = FLOOR(TotalValue); 

--------CONVERTING ALL SHORTFORMS INTO FULLFORM IN ADDRESS
----update FilterDatabase
----set Splitowneraddress2 = CASE WHEN Splitowneraddress2 = 'TN' THEN 'Tennessee'
----                              ELSE Splitowneraddress2
----							  END

--select Splitowneraddress2
--from FilterDatabase
