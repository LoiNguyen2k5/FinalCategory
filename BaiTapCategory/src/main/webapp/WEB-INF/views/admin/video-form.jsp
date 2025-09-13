<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<c:set var="pageTitle" value="Thêm Video mới" />
<c:set var="formAction" value="${pageContext.request.contextPath}/admin/videos/create" />
<c:if test="${not empty video}">
    <c:set var="pageTitle" value="Chỉnh sửa Video" />
    <c:set var="formAction" value="${pageContext.request.contextPath}/admin/videos/update" />
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            backdrop-filter: blur(20px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            padding: 40px;
            width: 100%;
            max-width: 600px;
            animation: slideUp 0.8s ease-out;
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h2 {
            color: #2d3748;
            font-size: 2.5em;
            font-weight: 700;
            text-align: center;
            margin-bottom: 40px;
            position: relative;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 4px;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border-radius: 2px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        label {
            display: block;
            color: #4a5568;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 15px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8fafc;
            font-family: inherit;
        }

        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #4facfe;
            background: white;
            box-shadow: 0 0 0 3px rgba(79, 172, 254, 0.1);
            transform: translateY(-2px);
        }

        textarea {
            resize: vertical;
            min-height: 120px;
            font-family: inherit;
        }

        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            border: none;
            padding: 18px 30px;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 20px;
            position: relative;
            overflow: hidden;
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(79, 172, 254, 0.4);
        }

        .btn-submit:active {
            transform: translateY(-1px);
        }

        .back-link {
            display: inline-block;
            margin-top: 25px;
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            padding: 12px 25px;
            border: 2px solid #667eea;
            border-radius: 25px;
            transition: all 0.3s ease;
            text-align: center;
            width: 100%;
        }

        .back-link:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        /* Form Animation */
        .form-group {
            animation: fadeInUp 0.6s ease-out forwards;
            opacity: 0;
            transform: translateY(20px);
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .form-group:nth-child(4) { animation-delay: 0.4s; }
        .btn-submit { animation: fadeInUp 0.6s ease-out 0.5s forwards; opacity: 0; transform: translateY(20px); }
        .back-link { animation: fadeInUp 0.6s ease-out 0.6s forwards; opacity: 0; transform: translateY(20px); }

        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Input Icons */
        .form-group.has-icon {
            position: relative;
        }

        .form-group.has-icon::before {
            content: '';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            width: 20px;
            height: 20px;
            background-size: contain;
            background-repeat: no-repeat;
            z-index: 2;
        }

        .form-group.title-group::before {
            content: '🎬';
            font-size: 18px;
        }

        .form-group.url-group::before {
            content: '🔗';
            font-size: 18px;
        }

        .form-group.description-group::before {
            content: '📝';
            font-size: 18px;
            top: 45px;
        }

        .form-group.has-icon input,
        .form-group.has-icon textarea {
            padding-left: 50px;
        }

        /* Validation States */
        .form-group.error input,
        .form-group.error textarea {
            border-color: #f56565;
            background: #fef5e7;
        }

        .form-group.success input,
        .form-group.success textarea {
            border-color: #48bb78;
            background: #f0fff4;
        }

        /* Loading State */
        .btn-submit.loading {
            pointer-events: none;
            position: relative;
        }

        .btn-submit.loading::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            top: 50%;
            left: 50%;
            margin-left: -10px;
            margin-top: -10px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top: 2px solid #fff;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            .form-container {
                padding: 25px;
                margin: 0;
            }

            h2 {
                font-size: 2em;
                margin-bottom: 30px;
            }

            input[type="text"],
            textarea {
                padding: 12px 15px;
                font-size: 14px;
            }

            .form-group.has-icon input,
            .form-group.has-icon textarea {
                padding-left: 40px;
            }

            .btn-submit {
                padding: 15px 25px;
                font-size: 14px;
            }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 6px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f5f9;
        }

        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 3px;
        }

        /* Ripple Effect */
        .ripple {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.4);
            transform: scale(0);
            animation: ripple-animation 0.6s linear;
            pointer-events: none;
        }

        @keyframes ripple-animation {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }

        /* Preview Section for URL */
        .url-preview {
            margin-top: 10px;
            padding: 10px;
            background: #f7fafc;
            border-radius: 8px;
            border-left: 4px solid #4facfe;
            display: none;
        }

        .url-preview.show {
            display: block;
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .url-preview iframe {
            width: 100%;
            height: 200px;
            border: none;
            border-radius: 8px;
        }

        .url-preview-text {
            font-size: 12px;
            color: #718096;
            margin-bottom: 8px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>${pageTitle}</h2>
        <form action="${formAction}" method="post" id="videoForm">
            <c:if test="${not empty video}">
                <input type="hidden" name="id" value="${video.id}" />
            </c:if>
            
            <div class="form-group has-icon title-group">
                <label for="title">Tiêu đề:</label>
                <input type="text" id="title" name="title" value="${video.title}" required 
                       placeholder="Nhập tiêu đề video..."/>
            </div>
            
            <div class="form-group has-icon url-group">
                <label for="url">URL Video:</label>
                <input type="text" id="url" name="url" value="${video.url}" required 
                       placeholder="https://youtube.com/watch?v=..."/>
                <div class="url-preview" id="urlPreview">
                    <div class="url-preview-text">Xem trước video:</div>
                    <div id="videoPreview"></div>
                </div>
            </div>
            
            <div class="form-group has-icon description-group">
                <label for="description">Mô tả:</label>
                <textarea id="description" name="description" rows="4" 
                          placeholder="Nhập mô tả cho video...">${video.description}</textarea>
            </div>
            
            <button type="submit" class="btn-submit" id="submitBtn">
                ${empty video ? 'Thêm mới' : 'Cập nhật'}
            </button>
        </form>
        <a href="${pageContext.request.contextPath}/admin/videos" class="back-link">
            ← Quay lại danh sách
        </a>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('videoForm');
            const submitBtn = document.getElementById('submitBtn');
            const urlInput = document.getElementById('url');
            const urlPreview = document.getElementById('urlPreview');
            const videoPreview = document.getElementById('videoPreview');

            // Form validation
            const inputs = form.querySelectorAll('input[required], textarea[required]');
            
            inputs.forEach(input => {
                input.addEventListener('blur', validateInput);
                input.addEventListener('input', clearValidation);
            });

            function validateInput(e) {
                const input = e.target;
                const formGroup = input.closest('.form-group');
                
                if (input.value.trim() === '') {
                    formGroup.classList.add('error');
                    formGroup.classList.remove('success');
                } else {
                    formGroup.classList.remove('error');
                    formGroup.classList.add('success');
                }
            }

            function clearValidation(e) {
                const input = e.target;
                const formGroup = input.closest('.form-group');
                formGroup.classList.remove('error', 'success');
            }

            // URL Preview functionality
            let previewTimeout;
            urlInput.addEventListener('input', function() {
                clearTimeout(previewTimeout);
                previewTimeout = setTimeout(() => {
                    const url = this.value.trim();
                    if (url && isValidVideoUrl(url)) {
                        showVideoPreview(url);
                    } else {
                        hideVideoPreview();
                    }
                }, 500);
            });

            function isValidVideoUrl(url) {
                return url.includes('youtube.com') || url.includes('youtu.be') || 
                       url.includes('vimeo.com') || url.includes('dailymotion.com');
            }

            function showVideoPreview(url) {
                let embedUrl = '';
                
                if (url.includes('youtube.com') || url.includes('youtu.be')) {
                    const videoId = extractYouTubeId(url);
                    if (videoId) {
                        embedUrl = `https://www.youtube.com/embed/${videoId}`;
                    }
                } else if (url.includes('vimeo.com')) {
                    const videoId = extractVimeoId(url);
                    if (videoId) {
                        embedUrl = `https://player.vimeo.com/video/${videoId}`;
                    }
                }

                if (embedUrl) {
                    videoPreview.innerHTML = `<iframe src="${embedUrl}" allowfullscreen></iframe>`;
                    urlPreview.classList.add('show');
                }
            }

            function hideVideoPreview() {
                urlPreview.classList.remove('show');
            }

            function extractYouTubeId(url) {
                const regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/;
                const match = url.match(regExp);
                return (match && match[7].length === 11) ? match[7] : null;
            }

            function extractVimeoId(url) {
                const regExp = /vimeo.com\/(\d+)/;
                const match = url.match(regExp);
                return match ? match[1] : null;
            }

            // Form submission with loading state
            form.addEventListener('submit', function(e) {
                let isValid = true;
                
                inputs.forEach(input => {
                    if (input.value.trim() === '') {
                        const formGroup = input.closest('.form-group');
                        formGroup.classList.add('error');
                        isValid = false;
                    }
                });

                if (!isValid) {
                    e.preventDefault();
                    return;
                }

                // Add loading state
                submitBtn.classList.add('loading');
                submitBtn.disabled = true;
                
                // Re-enable button after 3 seconds (fallback)
                setTimeout(() => {
                    submitBtn.classList.remove('loading');
                    submitBtn.disabled = false;
                }, 3000);
            });

            // Ripple effect for buttons
            document.querySelectorAll('.btn-submit, .back-link').forEach(button => {
                button.addEventListener('click', function(e) {
                    const ripple = document.createElement('span');
                    const rect = this.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;
                    
                    ripple.style.width = ripple.style.height = size + 'px';
                    ripple.style.left = x + 'px';
                    ripple.style.top = y + 'px';
                    ripple.style.position = 'absolute';
                    ripple.classList.add('ripple');
                    
                    if (getComputedStyle(this).position === 'static') {
                        this.style.position = 'relative';
                    }
                    
                    this.appendChild(ripple);
                    
                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });

            // Auto-resize textarea
            const textarea = document.getElementById('description');
            textarea.addEventListener('input', function() {
                this.style.height = 'auto';
                this.style.height = this.scrollHeight + 'px';
            });
        });
    </script>
</body>
</html>