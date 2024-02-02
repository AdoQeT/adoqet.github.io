// ./js/discord-status.js

function fetchData() {
    // Lanyard API'den verileri çekme
    fetch('https://api.lanyard.rest/v1/users/614408768733708288')
        .then(response => response.json())
        .then(data => {
            // Verileri işleme
            if (data.success) {
                // Diğer kodlar buraya taşınabilir
                const username = data.data.discord_user.username;
                const avatarUrl = `https://cdn.discordapp.com/avatars/${data.data.discord_user.id}/${data.data.discord_user.avatar}.png`;
                const statusElement = document.getElementById('statusText');
                const statusDot = document.querySelector('.status-dot');
                const userStatus = data.data.discord_status || 'Offline';

                statusElement.innerText = userStatus;

                // Duruma göre renk değiştirme
                switch (userStatus) {
                    case 'online':
                        statusDot.style.backgroundColor = 'lime';
                        break;
                    case 'idle':
                        statusDot.style.backgroundColor = 'yellow';
                        break;
                    case 'dnd':
                        statusDot.style.backgroundColor = 'red';
                        break;
                    default:
                        statusDot.style.backgroundColor = '#555'; // Offline veya diğer durumlar için varsayılan renk
                        break;
                }

                document.getElementById('username').innerText = username;
                document.getElementById('avatar').src = avatarUrl;

                const activities = data.data.activities;

                const activityListElement = document.getElementById('activityList');
                activityListElement.innerHTML = ''; // Önceki aktiviteleri temizle

                // ...

                activities.forEach(activity => {
                    const activityDiv = document.createElement('div');
                    activityDiv.classList.add('activity');
                
                    const activityImage = document.createElement('img');
                
                    if (activity.name === 'YouTube') {
                        // PreMid aktivitesi ise
                        const largeImage = 'https://media.discordapp.net/attachments/756651694187610195/1202893187119841290/yt.png?ex=65cf1c94&is=65bca794&hm=a5a8c43f6a6bedec75c2926e34c54266105c2d9689f80e143531df25948e7932&=&format=webp&quality=lossless&width=183&height=183'
                
                        activityImage.src = largeImage;
                    } else if (activity.type === 2 && activity.assets && activity.assets.large_image && activity.assets.large_image.startsWith('spotify:')) {
                        // Spotify aktivitesi ise
                        const spotifyImageId = activity.assets.large_image.split(':')[1];
                        activityImage.src = `https://i.scdn.co/image/${spotifyImageId}`;
                    } else {
                        // Diğer aktiviteler
                        activityImage.src = activity.assets && activity.assets.large_image
                            ? `https://cdn.discordapp.com/app-assets/${activity.application_id}/${activity.assets.large_image}.png`
                            : 'https://cdn.glitch.global/3319ca89-a9f9-4517-bdaa-0c4a50a8df48/unknown_game_img.png?v=1706792626199';
                    }
                
                    activityImage.alt = 'Activity Image';
                    activityImage.width = 0;
                
                    const activityDetailsDiv = document.createElement('div');
                
                    const activityName = document.createElement('p');
                    activityName.id = 'activityName';
                    activityName.innerText = activity.name || 'Unknown Activity';
                
                    const activityState = document.createElement('p');
                    activityState.innerText = activity.state || '';
                
                    const activityDetails = document.createElement('p');
                    activityDetails.innerText = activity.details || '';
                
                    activityDetailsDiv.appendChild(activityName);
                    activityDetailsDiv.appendChild(activityState);
                    activityDetailsDiv.appendChild(activityDetails);
                
                    activityDiv.appendChild(activityImage);
                    activityDiv.appendChild(activityDetailsDiv);
                
                    activityListElement.appendChild(activityDiv);
                });

                // ...

            } else {
                console.error('Lanyard API\'sinden veri çekme başarısız.');
            }
        })
        .catch(error => {
            console.error('Veri çekme sırasında bir hata oluştu:', error);
        });
}

// Belirli saniyede bir güncelleme yapmak için setInterval kullanımı
const updateInterval = 1000; // 60 saniye (bir dakika)
setInterval(fetchData, updateInterval);

// Sayfa yüklendiğinde de bir kere çalıştırmak için
fetchData();
