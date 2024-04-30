-- SAMPLE
-- Sample [Block] (sample_percent) [Seed (seed_value)]
Select *
From departments
Sample (70);
-- 27행인데 Sample(30)을 하면 7행만 출력된다.

Select *
From departments
Sample Block (50);
-- Block 샘플링, Block은 뭘까?

Select *
From departments
Sample (50) Seed (154);
-- Seed는 seed_value에 따라서 항상 동일한 샘플을 반환한다



