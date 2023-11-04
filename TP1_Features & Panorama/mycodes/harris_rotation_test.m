% Load images
ship1 = imread('../images/ship1.jpg');
ship2 = imread('../images/ship2.jpg');

% Detect Harris corner features in ship1 and ship2
features_ship1 = detectHarrisFeatures(ship1);
features_ship2 = detectHarrisFeatures(ship2);

% Visualize detected features (optional)
figure;
imshow(ship1);
hold on;
plot(features_ship1);
title('Detected Harris Corner Features in Ship1');

figure;
imshow(ship2);
hold on;
plot(features_ship2);
title('Detected Harris Corner Features in Ship2');

% Rotate the images
rotated_ship1 = imrotate(ship1, 30); % Rotate ship1 by 30 degrees
rotated_ship2 = imrotate(ship2, 30); % Rotate ship2 by 30 degrees

% Detect Harris corner features in the rotated images
features_rotated_ship1 = detectHarrisFeatures(rotated_ship1);
features_rotated_ship2 = detectHarrisFeatures(rotated_ship2);

% Visualize detected features in the rotated images (optional)
figure;
imshow(rotated_ship1);
hold on;
plot(features_rotated_ship1);
title('Detected Harris Corner Features in Rotated Ship1');

figure;
imshow(rotated_ship2);
hold on;
plot(features_rotated_ship2);
title('Detected Harris Corner Features in Rotated Ship2');
