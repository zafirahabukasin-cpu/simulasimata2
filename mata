<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simulasi Mata - Terang dan Gelap</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #8e44ad 0%, #9b59b6 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            transition: all 0.8s ease;
        }

        .container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 600px;
            width: 100%;
        }

        .language-toggle {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
            gap: 5px;
        }

        .lang-btn {
            padding: 8px 16px;
            border: 2px solid #4a90e2;
            background: transparent;
            color: #4a90e2;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }

        .lang-btn:hover {
            background: rgba(74, 144, 226, 0.1);
        }

        .lang-btn.active {
            background: #4a90e2;
            color: white;
        }

        h1 {
            color: #333;
            margin-bottom: 15px;
            font-size: 2.5rem;
            font-weight: 700;
        }

        .subtitle {
            color: #666;
            font-size: 1.2rem;
            margin-bottom: 30px;
            font-style: italic;
        }

        .eye-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 40px 0;
            gap: 60px;
            position: relative;
        }

        .eye-wrapper {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 2;
        }

        .environment-box {
            width: 520px;
            height: 140px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1.3rem;
            transition: all 0.8s ease;
            border: 3px solid #333;
            position: absolute;
            z-index: 1;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .environment-box.bright {
            background: linear-gradient(135deg, #ffd700, #ffed4e);
            color: #333;
            box-shadow: 0 0 20px rgba(255, 215, 0, 0.5);
        }

        .environment-box.dark {
            background: linear-gradient(135deg, #2c3e50, #34495e);
            color: white;
            box-shadow: 0 0 20px rgba(44, 62, 80, 0.5);
        }

        .eye {
            width: 200px;
            height: 120px;
            background: white;
            border-radius: 100px 100px 100px 100px;
            position: relative;
            box-shadow: inset 0 0 20px rgba(0, 0, 0, 0.1);
            border: 3px solid #333;
            z-index: 2;
        }

        .iris {
            width: 80px;
            height: 80px;
            background: radial-gradient(circle, #4a90e2 0%, #2c5aa0 70%, #1a365d 100%);
            border-radius: 50%;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            transition: all 0.8s ease;
        }

        .pupil {
            background: #000;
            border-radius: 50%;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            transition: all 0.8s ease;
        }

        .pupil.bright {
            width: 20px;
            height: 20px;
        }

        .pupil.dark {
            width: 60px;
            height: 60px;
        }

        .highlight {
            width: 15px;
            height: 15px;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 50%;
            position: absolute;
            top: 25%;
            left: 30%;
        }

        .controls {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin: 30px 0;
        }

        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-bright {
            background: linear-gradient(45deg, #ffd700, #ffed4e);
            color: #333;
        }

        .btn-bright:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.4);
        }

        .btn-dark {
            background: linear-gradient(45deg, #2c3e50, #34495e);
            color: white;
        }

        .btn-dark:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(44, 62, 80, 0.4);
        }

        .info {
            background: rgba(74, 144, 226, 0.1);
            border-left: 4px solid #4a90e2;
            padding: 20px;
            margin: 30px 0;
            border-radius: 8px;
            text-align: left;
        }

        .info h3 {
            color: #2c5aa0;
            margin-bottom: 10px;
            font-size: 1.3rem;
        }

        .info p {
            color: #555;
            line-height: 1.6;
            margin-bottom: 10px;
        }

        .status {
            font-size: 1.2rem;
            font-weight: 600;
            margin: 20px 0;
            padding: 15px;
            border-radius: 10px;
            transition: all 0.5s ease;
        }

        .status.bright {
            background: rgba(255, 215, 0, 0.2);
            color: #b8860b;
            border: 2px solid #ffd700;
        }

        .status.dark {
            background: rgba(44, 62, 80, 0.2);
            color: #2c3e50;
            border: 2px solid #34495e;
        }

        /* Environment effects */
        body.bright-env {
            background: linear-gradient(135deg, #8e44ad 0%, #9b59b6 100%);
        }

        body.dark-env {
            background: linear-gradient(135deg, #8e44ad 0%, #9b59b6 100%);
        }

        body.bright-env .container {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 20px 40px rgba(255, 215, 0, 0.3);
        }

        body.dark-env .container {
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
        }

        @media (max-width: 768px) {
            .eye-container {
                flex-direction: column;
                gap: 30px;
            }
            
            .controls {
                flex-direction: column;
                align-items: center;
            }
            
            h1 {
                font-size: 2rem;
            }
            
            .eye {
                width: 160px;
                height: 100px;
            }
            
            .iris {
                width: 65px;
                height: 65px;
            }
            
            .environment-box {
                width: 380px;
                height: 120px;
                font-size: 1.1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="language-toggle">
            <button class="lang-btn active" onclick="setLanguage('ms')" id="lang-ms">BM</button>
            <button class="lang-btn" onclick="setLanguage('en')" id="lang-en">EN</button>
        </div>
        
        <h1 id="main-title">Simulasi Pupil pada Mata</h1>
        <p class="subtitle" id="subtitle">Lihat bagaimana pupil pada mata bertindak balas terhadap perubahan cahaya</p>
        
        <div class="eye-container">
            <div class="environment-box bright" id="env-box"></div>
            <div class="eye-wrapper">
                <div class="eye">
                    <div class="iris">
                        <div class="pupil bright" id="pupil1">
                            <div class="highlight"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="eye-wrapper">
                <div class="eye">
                    <div class="iris">
                        <div class="pupil bright" id="pupil2">
                            <div class="highlight"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="status bright" id="status">
            ☀️ Tempat Terang - Pupil Mengecil
        </div>

        <div class="controls">
            <button class="btn btn-bright" onclick="setBrightEnvironment()" id="btn-bright">
                ☀️ Tempat Terang
            </button>
            <button class="btn btn-dark" onclick="setDarkEnvironment()" id="btn-dark">
                🌙 Tempat Gelap
            </button>
        </div>

        <div class="info">
            <h3 id="info-title">Bagaimana Pupil pada Mata Berfungsi?</h3>
            <p id="info-bright"><strong id="bright-label">Di tempat terang:</strong> <span id="bright-desc">Pupil mengecil untuk melindungi retina daripada cahaya berlebihan dan memberikan penglihatan yang tajam.</span></p>
            <p id="info-dark"><strong id="dark-label">Di tempat gelap:</strong> <span id="dark-desc">Pupil membesar untuk membenarkan lebih banyak cahaya masuk supaya kita boleh melihat dalam keadaan cahaya minimum.</span></p>
            <p id="info-process"><strong id="process-label">Proses ini:</strong> <span id="process-desc">Dikawal oleh otot iris secara automatik dan berlaku dalam beberapa saat sebagai tindak balas terhadap perubahan intensiti cahaya.</span></p>
        </div>
    </div>

    <script>
        let currentLanguage = 'ms';
        
        const translations = {
            ms: {
                title: 'Simulasi Pupil pada Mata',
                subtitle: 'Lihat bagaimana pupil pada mata bertindak balas terhadap perubahan cahaya',
                btnBright: '☀️ Tempat Terang',
                btnDark: '🌙 Tempat Gelap',
                statusBright: '☀️ Tempat Terang - Pupil Mengecil',
                statusDark: '🌙 Tempat Gelap - Pupil Membesar',
                envBright: '☀️ TERANG',
                envDark: '🌙 GELAP',
                infoTitle: 'Bagaimana Pupil pada Mata Berfungsi?',
                brightLabel: 'Di tempat terang:',
                brightDesc: 'Pupil mengecil (konstriksi) untuk melindungi retina daripada cahaya berlebihan dan memberikan penglihatan yang tajam.',
                darkLabel: 'Di tempat gelap:',
                darkDesc: 'Pupil membesar (dilatasi) untuk membenarkan lebih banyak cahaya masuk supaya kita boleh melihat dalam keadaan cahaya minimum.',
                processLabel: 'Proses ini:',
                processDesc: 'Dikawal oleh otot iris secara automatik dan berlaku dalam beberapa saat sebagai tindak balas terhadap perubahan intensiti cahaya.'
            },
            en: {
                title: 'Eye Pupil Simulation',
                subtitle: 'See how the pupils in the eyes respond to changes in light',
                btnBright: '☀️ Bright Places',
                btnDark: '🌙 Dark Places',
                statusBright: '☀️ Bright Places - Pupils Constrict',
                statusDark: '🌙 Dark Places - Pupils Dilate',
                envBright: '☀️ BRIGHT',
                envDark: '🌙 DARK',
                infoTitle: 'How Do Eye Pupils Function?',
                brightLabel: 'In bright places:',
                brightDesc: 'Pupils constrict to protect the retina from excessive light and provide sharp vision.',
                darkLabel: 'In dark places:',
                darkDesc: 'Pupils dilate to allow more light to enter so we can see in minimal light conditions.',
                processLabel: 'This process:',
                processDesc: 'Is controlled by the iris muscles automatically and occurs within seconds as a response to changes in light intensity.'
            }
        };

        function setLanguage(lang) {
            currentLanguage = lang;
            
            // Update active button
            document.querySelectorAll('.lang-btn').forEach(btn => btn.classList.remove('active'));
            document.getElementById('lang-' + lang).classList.add('active');
            
            // Update all text content
            const t = translations[lang];
            document.getElementById('main-title').textContent = t.title;
            document.getElementById('subtitle').textContent = t.subtitle;
            document.getElementById('btn-bright').innerHTML = t.btnBright;
            document.getElementById('btn-dark').innerHTML = t.btnDark;
            document.getElementById('info-title').textContent = t.infoTitle;
            document.getElementById('bright-label').textContent = t.brightLabel;
            document.getElementById('bright-desc').textContent = t.brightDesc;
            document.getElementById('dark-label').textContent = t.darkLabel;
            document.getElementById('dark-desc').textContent = t.darkDesc;
            document.getElementById('process-label').textContent = t.processLabel;
            document.getElementById('process-desc').textContent = t.processDesc;
            
            // Update environment boxes
            updateEnvironmentBoxes();
            
            // Update status based on current state
            updateStatus();
        }

        function updateStatus() {
            const status = document.getElementById('status');
            const t = translations[currentLanguage];
            
            if (status.classList.contains('bright')) {
                status.innerHTML = t.statusBright;
            } else {
                status.innerHTML = t.statusDark;
            }
        }

        function updateEnvironmentBoxes() {
            // Environment box now has no text content
        }

        function setBrightEnvironment() {
            // Change pupils to small size
            const pupils = document.querySelectorAll('.pupil');
            pupils.forEach(pupil => {
                pupil.classList.remove('dark');
                pupil.classList.add('bright');
            });

            // Change environment
            document.body.classList.remove('dark-env');
            document.body.classList.add('bright-env');

            // Update status
            const status = document.getElementById('status');
            status.classList.remove('dark');
            status.classList.add('bright');
            
            // Update environment boxes
            const envBoxes = document.querySelectorAll('.environment-box');
            envBoxes.forEach(box => {
                box.classList.remove('dark');
                box.classList.add('bright');
            });
            
            updateStatus();
            updateEnvironmentBoxes();
        }

        function setDarkEnvironment() {
            // Change pupils to large size
            const pupils = document.querySelectorAll('.pupil');
            pupils.forEach(pupil => {
                pupil.classList.remove('bright');
                pupil.classList.add('dark');
            });

            // Change environment
            document.body.classList.remove('bright-env');
            document.body.classList.add('dark-env');

            // Update status
            const status = document.getElementById('status');
            status.classList.remove('bright');
            status.classList.add('dark');
            
            // Update environment boxes
            const envBoxes = document.querySelectorAll('.environment-box');
            envBoxes.forEach(box => {
                box.classList.remove('bright');
                box.classList.add('dark');
            });
            
            updateStatus();
            updateEnvironmentBoxes();
        }

        // Auto demonstration
        let autoDemo = true;
        let currentState = 'bright';

        function autoDemonstration() {
            if (autoDemo) {
                setTimeout(() => {
                    if (currentState === 'bright') {
                        setDarkEnvironment();
                        currentState = 'dark';
                    } else {
                        setBrightEnvironment();
                        currentState = 'bright';
                    }
                    autoDemonstration();
                }, 4000);
            }
        }

        // Start auto demo
        setTimeout(() => {
            autoDemonstration();
        }, 2000);

        // Stop auto demo when user interacts
        document.querySelectorAll('.btn').forEach(btn => {
            btn.addEventListener('click', () => {
                autoDemo = false;
            });
        });
    </script>
<script>(function(){function c(){var b=a.contentDocument||a.contentWindow.document;if(b){var d=b.createElement('script');d.innerHTML="window.__CF$cv$params={r:'98161ed7b7138177',t:'MTc1ODI1Mzg0My4wMDAwMDA='};var a=document.createElement('script');a.nonce='';a.src='/cdn-cgi/challenge-platform/scripts/jsd/main.js';document.getElementsByTagName('head')[0].appendChild(a);";b.getElementsByTagName('head')[0].appendChild(d)}}if(document.body){var a=document.createElement('iframe');a.height=1;a.width=1;a.style.position='absolute';a.style.top=0;a.style.left=0;a.style.border='none';a.style.visibility='hidden';document.body.appendChild(a);if('loading'!==document.readyState)c();else if(window.addEventListener)document.addEventListener('DOMContentLoaded',c);else{var e=document.onreadystatechange||function(){};document.onreadystatechange=function(b){e(b);'loading'!==document.readyState&&(document.onreadystatechange=e,c())}}}})();</script></body>
</html>
